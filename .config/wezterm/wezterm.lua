-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "GruvboxDark"
  else
    return "GruvboxLight"
  end
end

-- For example, changing the color scheme:
config.color_scheme = scheme_for_appearance(get_appearance())

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.window_decorations = "RESIZE"

config.window_padding = {
  top = 3,
  right = 0,
  bottom = 0,
  left = 3,
}

config.font_size = 13.5
config.adjust_window_size_when_changing_font_size = true
config.native_macos_fullscreen_mode = true

-- and finally, return the configuration to wezterm
return config
