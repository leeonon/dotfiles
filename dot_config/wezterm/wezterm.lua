local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 14.0
-- config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("ComicShannsMono Nerd Font", { weight = "Regular" })
-- config.font = wezterm.font("Monaspace Neon", { weight = "Regular" })
-- config.font = wezterm.font("RecMonoDuotone Nerd Font", { weight = "Regular" })

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.adjust_window_size_when_changing_font_size = false
config.term = "xterm-256color"

-- custon theme
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#1e1c31"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"
config.color_schemes = {
	["Costom Catppuccin Mocha"] = custom,
}
config.color_scheme = "Custom Catppuccin Mocha"

-- 设置 wezterm 窗口大小
config.initial_rows = 45
config.initial_cols = 150

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
