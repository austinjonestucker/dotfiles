#!/usr/bin/env python3
# Save the active kitty session with --use-foreground-process, then rewrite
# launch cmds back to wrapper-safe forms (pg/usql/ssh/nvim/agent) so restore
# goes through zsh/1Password helpers instead of absolute binaries + secret URIs.

from __future__ import annotations

import json
import os
import re
import shlex
import subprocess
from functools import partial
from gettext import gettext as _
from typing import Any
from urllib.parse import unquote, urlparse

from kitty.boss import Boss
from kitty.session import (
    parse_save_as_options_spec_args,
    save_as_session_part2,
    seen_session_paths,
)
from kittens.tui.handler import result_handler

SESSIONS_DIR = os.path.expanduser('~/.local/share/kitty/sessions')
USQL_CONFIG = os.path.expanduser('~/.config/usql/config.yaml')

_LAUNCH_RE = re.compile(
    r"^(launch ')(kitty-unserialize-data=)(\{.*\})(')\s*$"
)


def main(args: list[str]) -> str:
    return ''


def _basename(path: str) -> str:
    return os.path.basename(path.rstrip('/')) or path


def _flatten_cmd(cmd: Any) -> list[str]:
    """Normalize cmd_at_shell_startup to an argv-like list."""
    if cmd is None or cmd == '' or cmd == []:
        return []
    if isinstance(cmd, str):
        try:
            return shlex.split(cmd)
        except ValueError:
            return [cmd]
    if isinstance(cmd, list):
        parts: list[str] = []
        for item in cmd:
            if item is None or item == '':
                continue
            if isinstance(item, str) and (' ' in item or '://' in item) and parts == []:
                try:
                    parts.extend(shlex.split(item))
                except ValueError:
                    parts.append(item)
            else:
                parts.append(str(item))
        return parts
    return [str(cmd)]


def _load_usql_connections() -> dict[str, dict[str, str]]:
    if not os.path.isfile(USQL_CONFIG):
        return {}
    try:
        out = subprocess.check_output(
            ['yq', '-o=json', '.connections', USQL_CONFIG],
            text=True,
        )
        data = json.loads(out)
        return data if isinstance(data, dict) else {}
    except Exception:
        return {}


def _usql_name_for_uri(uri: str, connections: dict[str, dict[str, str]]) -> str | None:
    try:
        parsed = urlparse(uri)
    except Exception:
        return None
    host = parsed.hostname or ''
    port = str(parsed.port or '')
    database = unquote((parsed.path or '').lstrip('/'))
    protocol = (parsed.scheme or '').split('+')[0]

    for name, cfg in connections.items():
        if not isinstance(cfg, dict):
            continue
        if (
            str(cfg.get('hostname', '')) == host
            and str(cfg.get('database', '')) == database
            and (not port or str(cfg.get('port', '')) == port)
            and (
                not protocol
                or str(cfg.get('protocol', '')).startswith(protocol)
                or protocol.startswith(str(cfg.get('protocol', '')))
            )
        ):
            return name

    stem = database.split('.')[0] if database else ''
    if stem and stem in connections:
        return stem
    return None


def _postgres_db_from_uri(uri: str) -> str | None:
    try:
        parsed = urlparse(uri)
    except Exception:
        return None
    db = unquote((parsed.path or '').lstrip('/'))
    return db or None


def sanitize_argv(argv: list[str], usql_conns: dict[str, dict[str, str]]) -> str | None:
    """Return a wrapper-safe shell command string, or None to clear startup cmd."""
    if not argv:
        return None

    head = _basename(argv[0])
    # Already a safe wrapper-style invocation (no credential URIs).
    if head in {'pg', 'usql', 'ssh', 'scp', 'nvim', 'vim', 'agent'} and not any(
        '://' in a for a in argv
    ):
        return shlex.join([head, *argv[1:]])

    joined = ' '.join(argv)

    if 'pgcli' in joined or (head.lower() == 'python' and 'postgres://' in joined):
        for part in argv:
            if 'postgres://' in part or 'postgresql://' in part:
                m = re.search(r'(postgres(?:ql)?://\S+)', part)
                uri = m.group(1) if m else part
                db = _postgres_db_from_uri(uri)
                if db:
                    return f'pg {shlex.quote(db)}'
        return 'pg'

    if head == 'usql' or joined.startswith('usql ') or '/bin/usql' in argv[0]:
        for part in argv[1:] if len(argv) > 1 else argv:
            if '://' in part:
                m = re.search(
                    r'((?:postgres|postgresql|oracle|mysql|sqlserver|sqlite|duckdb|maria|ms|pg)://\S+)',
                    part,
                )
                uri = m.group(1) if m else part
                name = _usql_name_for_uri(uri, usql_conns)
                if name:
                    return f'usql {shlex.quote(name)}'
                return None
        if len(argv) > 1 and '://' not in argv[1]:
            return shlex.join(['usql', *argv[1:]])
        return None

    if head == 'ssh' or argv[0].endswith('/ssh'):
        return shlex.join(['ssh', *argv[1:]])

    if head == 'scp' or argv[0].endswith('/scp'):
        return shlex.join(['scp', *argv[1:]])

    if head in {'nvim', 'vim'} or argv[0].endswith('/nvim') or argv[0].endswith('/vim'):
        return shlex.join([head if head in {'nvim', 'vim'} else 'nvim', *argv[1:]])

    if head == 'agent' or re.search(r'/agent$', argv[0]) or (
        'index.js' in joined and ('cursor' in joined.lower() or '/.local/bin/' in joined)
    ):
        return 'agent'

    if 'language-server' in joined or 'tsserver' in joined:
        return None

    if argv[0].startswith('/') and '://' not in joined:
        return shlex.join([head, *argv[1:]])

    if '://' in joined:
        return None

    return shlex.join(argv)


def sanitize_session_file(path: str) -> None:
    with open(path, encoding='utf-8') as f:
        text = f.read()

    usql_conns = _load_usql_connections()
    out_lines: list[str] = []
    changed = False

    for line in text.splitlines(keepends=True):
        raw = line.rstrip('\n')
        newline = '\n' if line.endswith('\n') else ''
        m = _LAUNCH_RE.match(raw)
        if not m:
            out_lines.append(line)
            continue

        try:
            data = json.loads(m.group(3))
        except json.JSONDecodeError:
            out_lines.append(line)
            continue

        if 'cmd_at_shell_startup' not in data:
            out_lines.append(line)
            continue

        argv = _flatten_cmd(data['cmd_at_shell_startup'])
        new_cmd = sanitize_argv(argv, usql_conns)

        if new_cmd is None:
            data.pop('cmd_at_shell_startup', None)
        else:
            data['cmd_at_shell_startup'] = new_cmd

        new_json = json.dumps(data, separators=(',', ':'))
        new_line = f"{m.group(1)}{m.group(2)}{new_json}{m.group(4)}{newline}"
        if new_line != line:
            changed = True
        out_lines.append(new_line)

    if changed:
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(out_lines)


def _resolve_save_path(path: str, opts: Any, path_input_by_user: bool = False) -> str:
    if opts.base_dir and not os.path.isabs(path):
        base_dir = os.path.abspath(os.path.expanduser(opts.base_dir))
        path = os.path.join(base_dir, path)
    path = os.path.abspath(os.path.expanduser(path))
    if path_input_by_user and '.' not in os.path.basename(path):
        path += '.kitty-session'
    return path


def _save_then_sanitize(boss: Boss, opts: Any, path: str, path_input_by_user: bool = False) -> None:
    save_as_session_part2(boss, opts, path, path_input_by_user=path_input_by_user)
    full = _resolve_save_path(path, opts, path_input_by_user=path_input_by_user)
    if os.path.isfile(full):
        try:
            sanitize_session_file(full)
        except Exception as e:
            boss.show_error(_('Session sanitize failed'), str(e))


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    # Usage:
    #   kitten save_session_sanitized.py .
    #   kitten save_session_sanitized.py          # prompt for name
    mode = args[1] if len(args) > 1 else ''

    save_args = [
        '--save-only',
        '--use-foreground-process',
        '--match=session:.',
        f'--base-dir={SESSIONS_DIR}',
    ]
    opts, _unused = parse_save_as_options_spec_args(save_args)

    if mode == '.':
        sn = boss.active_session
        path = seen_session_paths.get(sn) or ''
        if path:
            _save_then_sanitize(boss, opts, path)
        else:
            boss.get_save_filepath(
                _('Enter the path at which to save the session'),
                partial(_save_then_sanitize, boss, opts, path_input_by_user=True),
            )
        return

    boss.get_save_filepath(
        _('Enter the path at which to save the session'),
        partial(_save_then_sanitize, boss, opts, path_input_by_user=True),
    )
