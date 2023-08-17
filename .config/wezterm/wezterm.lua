-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 3,
  right = 0,
  top = 0,
  bottom = 0,
}
config.font_size = 13.5
config.adjust_window_size_when_changing_font_size = true
config.native_macos_fullscreen_mode = true


-- and finally, return the configuration to wezterm
return config

