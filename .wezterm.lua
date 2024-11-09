-- Pull in the wezterm API
local wezterm = require 'wezterm'

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

--Key Bindings
config.keys = {
-- Jump word to the left
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'b', mods = 'ALT' },
  },
-- Jump word to the right
  {
    key = 'RightArrow',
    mods = 'OPT',
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
}
config.window_padding = {
  left = '0',
  right = '0',
  top = '15',
  bottom = '0',
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Requires WSL & Ubuntu to be installed
  config.default_domain = 'WSL:Ubuntu'
else
  -- Windows has font issues, so only change font in *nix
  config.font = wezterm.font('MesloLGS NF')
end

-- This is where you actually apply your config choices
config.color_scheme = 'Kanagawa (Gogh)'
config.font_size = 13
config.line_height = 0.925
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.use_dead_keys = false
config.scrollback_lines = 10000
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.native_macos_fullscreen_mode = false

-- and finally, return the configuration to wezterm
return config

