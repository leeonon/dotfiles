local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 14.0
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.color_scheme = "Catppuccin Mocha"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.window_background_opacity = 0.9
config.macos_window_background_blur = 40
config.adjust_window_size_when_changing_font_size = false
config.text_background_opacity = 0.9

-- 设置 wezterm 窗口大小
config.initial_rows = 45
config.initial_cols = 150

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 5,
}

return config
