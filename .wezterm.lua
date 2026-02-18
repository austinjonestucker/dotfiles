-- Pull in the wezterm API
local wezterm = require 'wezterm'
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")

-- This table will hold the configuration.
local config = {}

-- Manages the multiplexer layer, which is responsible for everything related to
-- panes, tabs, windows, and workspaces, but not the terminal itself
local mux = wezterm.mux
-- Manages key bindings to actions
local act = wezterm.action

-- When wezterm starts, maximize window
wezterm.on('gui-startup', function()
 local _, _, window = mux.spawn_window({})
 window:gui_window():maximize()
end)

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local theme = 'Kanagawa (Gogh)'
local ssh_theme = 'Gruvbox Dark (Gogh)'
local prd_ssh_theme = 'IC_Orange_PPL'

tabline.setup({
  options = {
    icons_enabled = true,
    theme = theme,
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      { 'process', padding = { left = 0, right = 0 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { { 'tab', padding = { left = 0, right = 0 } } },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime', 'battery' },
    tabline_z = { 'domain' },
  },
  extensions = { 'resurrect' },
})

-- Key Bindings
-- Add leader key
config.leader = {
  key = 'a',
  mods = 'CTRL',
  timeout_milliseconds = 2000,
}

config.keys = {
-- Jump word to the left
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = act.SendKey { key = 'b', mods = 'ALT' },
  },
-- Jump word to the right
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = act.SendKey { key = 'f', mods = 'ALT' },
  },
-- Delete word
  {
    key = 'Backspace',
    mods = 'ALT',
    action = act.SendKey { key = 'w', mods = 'CTRL' },
  },
-- Go to beginning of line
  {
    key = 'LeftArrow',
    mods = 'SUPER',
    action = act.SendKey { key = 'a', mods = 'CTRL' },
  },
-- Go to end of line
  {
    key = 'RightArrow',
    mods = 'SUPER',
    action = act.SendKey { key = 'e', mods = 'CTRL' },
  },
-- Delete line
  {
    key = 'Backspace',
    mods = 'SUPER',
    action = act.SendKey { key = 'u', mods = 'CTRL' },
  },
  -- Enter copy mode
  {
    key = '[',
    mods = 'LEADER',
    action = act.ActivateCopyMode,
  },
  -- Toggle pane zoom state
  {
    key = 'z',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },
  -- Spawn a new tab in the current domain
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
    -- Move between tabs
  {
    key = 'RightArrow',
    mods = 'SHIFT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'LeftArrow',
    mods = 'SHIFT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'LeftArrow',
    mods = 'SHIFT|CTRL',
    action = act.MoveTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT|CTRL',
    action = act.MoveTabRelative(1),
  },
  -- Rename tab
  {
    key = 'r',
    mods = 'LEADER',
    action = act.PromptInputLine {
    description = 'Enter new name for tab',
    action = wezterm.action_callback(
      function(window, _, line)
        if line then
        window:active_tab():set_title(line)
        end
      end
    ),
    },
  },
  -- Show tab navigator
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
  },
  -- Close tab
  {
    key = 'w',
    mods = 'SUPER',
    action = act.CloseCurrentTab{ confirm = true },
  },
  -- LEADER + (h,j,k,l) to move between panes
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Left'),
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Down'),
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Up'),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Right'),
  },
  {
    key = 'e',
    mods = 'SUPER',
    action = act.ActivatePaneDirection('Prev'),
  },
  {
    key = 'r',
    mods = 'SUPER',
    action = act.ActivatePaneDirection('Next'),
  },
  -- LEADER + SHIFT + (h,j,k,l) to resize panes
  {
    key = 'H',
    mods = 'LEADER|SHIFT',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'J',
    mods = 'LEADER|SHIFT',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  { key = 'K',
    mods = 'LEADER|SHIFT',
    action = act.AdjustPaneSize { 'Up', 5 } },
  {
    key = 'L',
    mods = 'LEADER|SHIFT',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
  -- Vertical split
  {
    -- |
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  -- Horizontal split
  {
    -- -
    key = '_',
    mods = 'LEADER|SHIFT',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  -- Pane selection mode
  {
    -- {
    key = '{',
    mods = 'LEADER|SHIFT',
    action = act.PaneSelect { mode = 'Activate' }
  },
  -- Pane swap
  {
    -- }
    key = '}',
    mods = 'LEADER|SHIFT',
    action = act.PaneSelect { mode = 'SwapWithActiveKeepFocus' }
  },
  -- Pane move to new tab
  {
    -- }
    key = '>',
    mods = 'LEADER|SHIFT',
    action = act.PaneSelect { mode = 'MoveToNewTab' }
  },
  -- Attach to muxer
  {
    key = 'a',
    mods = 'LEADER',
    action = act.AttachDomain 'unix',
  },

  -- Detach from muxer
  {
    key = 'd',
    mods = 'LEADER',
    action = act.DetachDomain { DomainName = 'unix' },
  },
  -- Rename current session; analagous to command in tmux
  {
    key = '$',
    mods = 'LEADER|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },
  -- Show list of workspaces
  {
    key = 's',
    mods = 'LEADER',
    action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
  },
    -- Session manager bindings
  {
    key = 'S',
    mods = 'LEADER|SHIFT',
    action = act({ EmitEvent = "save_session" }),
  },
  {
    key = 'L',
    mods = 'LEADER|SHIFT',
    action = act({ EmitEvent = "load_session" }),
  },
  {
    key = 'R',
    mods = 'LEADER|SHIFT',
    action = act({ EmitEvent = "restore_session" }),
  },
  {
    key = 'D',
    mods = 'LEADER|SHIFT',
    action = act({ EmitEvent = "delete_session" }),
  },
  {
    key = 'E',
    mods = 'LEADER|SHIFT',
    action = act({ EmitEvent = "edit_session" }),
  },
}
-- Mouse
config.mouse_bindings = {
  -- Change the default click behavior so that it only selects text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection('ClipboardAndPrimarySelection'),
  },
  -- Open links on Cmd+click
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- Window padding
config.window_padding = {
  left = '5',
  right = '0',
  top = '5',
  bottom = '0',
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Requires WSL & Ubuntu to be installed
  config.default_domain = 'WSL:Ubuntu'
  config.font_size = 11
else
  -- Tabs not needed in *nix with tmux & only one terminal
  config.hide_tab_bar_if_only_one_tab = true
  config.font_size = 13
end

-- Editor styling
config.color_scheme = theme
config.font = wezterm.font('MesloLGS NF')
config.line_height = 0.925
config.bold_brightens_ansi_colors = false
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.colors = {
  tab_bar = {
    background = '#1f1f28',
      new_tab = {
        bg_color = '#1f1f28',
        fg_color = '#c8c093',
      },
  },
}

-- Terminal styling
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.native_macos_fullscreen_mode = false
config.switch_to_last_active_tab_when_closing_tab = true
config.use_fancy_tab_bar = false
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.4,
}

-- Multiplexing
config.unix_domains = {
  {
    name = 'unix',
  },
}

-- Other configs
config.use_dead_keys = false
config.scrollback_lines = 10000
config.window_close_confirmation = 'AlwaysPrompt'
config.pane_focus_follows_mouse = true

-- SSH configs
wezterm.on('update-status',
  function(window, pane)
    local fg_process_info = pane:get_foreground_process_info()

    local overrides = window:get_config_overrides() or {}
    local fg_process_name = fg_process_info.executable
    local fg_process_args = fg_process_info.argv
    local fg_process_args_length = #fg_process_args
    local server = ''
    -- Change as needed
    local prd_indicator = 'pr'

    for i = 1, fg_process_args_length do
      if string.find(fg_process_args[i], '@') then
        server = string.sub(fg_process_args[i], string.find(fg_process_args[i], '@') + 1)
        break
      end
    end

    if fg_process_name == '/usr/bin/ssh' then
      if string.find(server, prd_indicator) then
        overrides.color_scheme = prd_ssh_theme
      else
        overrides.color_scheme = ssh_theme
      end
    else
      overrides.color_scheme = theme
    end

    window:set_config_overrides(overrides)
  end
)

return config
