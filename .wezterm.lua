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

-- This is where you actually apply your config choices
config.color_scheme = 'jubi'
config.font = wezterm.font('MesloLGS NF')
config.font_size = 13
config.line_height = 1.2
config.use_dead_keys = false
config.scrollback_lines = 10000
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config

