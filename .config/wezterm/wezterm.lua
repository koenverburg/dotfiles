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
		return "Solarized (light) (terminal.sexy)"
	end
end

-- For example, changing the color scheme:
config.color_scheme = scheme_for_appearance(get_appearance())

config.font = wezterm.font("JetBrainsMono Nerd Font", {
  weight = "Regular",
  bold = true,
})
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

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	-- Left = "h",
	-- Down = "j",
	-- Up = "k",
	-- Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "Space",
		mods = "LEADER",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	{
		key = "0",
		mods = "LEADER",
		action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }),
	},
	{
		key = "0",
		mods = "LEADER",
		action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }),
	},

	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
}

-- and finally, return the configuration to wezterm
return config
