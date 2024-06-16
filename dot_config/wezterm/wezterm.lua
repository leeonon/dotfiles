local wezterm = require("wezterm")
local k = require("utils/keys")
local h = require("utils/helpers")

local config = wezterm.config_builder()
local act = wezterm.action

config.font_size = 14.0
-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
-- config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
-- config.font = wezterm.font("ComicShannsMono Nerd Font Mono", { weight = "Bold" })
-- config.font = wezterm.font("ComicMono NF")
-- config.font = wezterm.font("Monaspace Neon", { weight = "Regular" })
-- config.font = wezterm.font("GeistMono Nerd Font", { weight = "Medium" })
-- config.font = wezterm.font("BlexMono Nerd Font Mono", { weight = "Medium", })
--
config.font = wezterm.font_with_fallback {
  { family = 'GeistMono Nerd Font',     weight = 'Medium' },
  { family = 'BlexMono Nerd Font Mono', weight = 'Medium' },
  'JeBrainsMono Nerd Font',
}
config.font_rules = {
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = 'BlexMono Nerd Font Mono',
      weight = 'Bold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Half',
    font = wezterm.font {
      family = 'BlexMono Nerd Font Mono',
      weight = 'DemiBold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font {
      family = 'BlexMono Nerd Font Mono',
      style = 'Italic',
    },
  },
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.window_background_opacity = 0.9
config.macos_window_background_blur = 64
config.adjust_window_size_when_changing_font_size = false
config.term = "xterm-256color"
config.default_cursor_style = "BlinkingBar"

-- custon theme
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#021727"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"
config.color_schemes = {
  ["Custom Catppuccin Mocha"] = custom,
}
config.color_scheme = "Custom Catppuccin Mocha"
-- config.color_scheme = "Catppuccin Mocha"

-- 设置 wezterm 窗口大小
config.initial_rows = 55
config.initial_cols = 150

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.keys = {
  k.cmd_key(".", k.multiple_actions(":ZenMode")),

  -- 跳回 跳进
  k.cmd_key("[", act.SendKey({ mods = "CTRL", key = "o" })),
  k.cmd_key("]", act.SendKey({ mods = "CTRL", key = "i" })),

  -- k.cmd_key("i", k.multiple_actions(":SmartGoTo")),

  -- 将 CMD + jkhl 绑定到 CTRL + jkhl 切换窗口
  -- k.cmd_key("J", act.SendKey({ mods = "CTRL", key = "j" })),
  -- k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
  -- k.cmd_key("H", act.SendKey({ mods = "CTRL", key = "h" })),
  -- k.cmd_key("L", act.SendKey({ mods = "CTRL", key = "l" })),

  -- Telescope 搜索相关
  k.cmd_key("f", k.multiple_actions(":Telescope live_grep\r")),
  k.cmd_key("O", k.multiple_actions(":Telescope treesitter\r")),
  k.cmd_key("p", k.multiple_actions(":Telescope find_files\r")),
  k.cmd_key("b", k.multiple_actions(":Telescope buffers\r")),

  -- 将 tmux 的前缀键绑定到 CMD 键
  k.cmd_to_tmux_prefix("1", "1"),
  k.cmd_to_tmux_prefix("2", "2"),
  k.cmd_to_tmux_prefix("3", "3"),
  k.cmd_to_tmux_prefix("4", "4"),
  k.cmd_to_tmux_prefix("5", "5"),
  k.cmd_to_tmux_prefix("6", "6"),
  k.cmd_to_tmux_prefix("7", "7"),
  k.cmd_to_tmux_prefix("8", "8"),
  k.cmd_to_tmux_prefix("9", "9"),
  k.cmd_to_tmux_prefix("`", "n"),
  k.cmd_to_tmux_prefix("b", "b"),
  k.cmd_to_tmux_prefix("C", "C"),
  k.cmd_to_tmux_prefix("d", "D"),
  k.cmd_to_tmux_prefix("G", "G"),
  k.cmd_to_tmux_prefix("g", "g"),
  k.cmd_to_tmux_prefix("j", "J"),
  k.cmd_to_tmux_prefix("K", "T"),
  k.cmd_to_tmux_prefix("k", "K"),
  k.cmd_to_tmux_prefix("l", "L"),
  k.cmd_to_tmux_prefix("n", '"'),
  k.cmd_to_tmux_prefix("N", "%"),
  k.cmd_to_tmux_prefix("o", "u"),
  k.cmd_to_tmux_prefix("T", "!"),
  k.cmd_to_tmux_prefix("Y", "Y"),
  k.cmd_to_tmux_prefix("t", "c"),
  k.cmd_to_tmux_prefix("z", "z"),
  k.cmd_to_tmux_prefix("Z", "Z"),
  k.cmd_to_tmux_prefix("w", "x"),
  -- k.cmd_to_tmux_prefix("x", "x"),

  k.cmd_key(
    "R",
    act.Multiple({
      act.SendKey({ key = "\x1b" }), -- escape
      k.multiple_actions(":source %"),
    })
  ),

  k.cmd_key(
    "s",
    act.Multiple({
      act.SendKey({ key = "\x1b" }), -- escape
      k.multiple_actions(":w\r"),
    })
  ),

  {
    mods = "CMD|SHIFT",
    key = "}",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "n" }),
    }),
  },
  {
    mods = "CMD|SHIFT",
    key = "{",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "p" }),
    }),
  },

  {
    mods = "CTRL",
    key = "Tab",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "n" }),
    }),
  },

  {
    mods = "CTRL|SHIFT",
    key = "Tab",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "n" }),
    }),
  },

  {
    mods = "CMD",
    key = "~",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "p" }),
    }),
  },
}
-- wezterm.on('update-right-status', function(window, pane)
--     if h.is_nvim_or_tmux(pane) then
--         window:set_config_overrides({ keys = keys })
--     else
--         window:set_config_overrides({ keys = nil }) -- 使用默认键绑定
--     end
-- end)

return config
