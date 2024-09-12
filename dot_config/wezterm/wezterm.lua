local wezterm = require("wezterm")
local k = require("utils/keys")

local config = wezterm.config_builder()
local act = wezterm.action

config.font_size = 14.0
config.font = wezterm.font_with_fallback({
  { family = "BlexMono Nerd Font",             weight = "Medium" },
  { family = "Monaspace Neon" },
  { family = "MonoLisa",                       weight = "Regular" },
  { family = "Iosevka Nerd Font Mono" },
  { family = "FantasqueSansM Nerd Font" },
  { family = "JetBrainsMono Nerd Font Mono",   scale = 1.0,       weight = "Medium" },
  { family = "IBM Plex Mono" },
  { family = "GeistMono Nerd Font",            weight = "Medium" },
  { family = "ComicShannsMono Nerd Font Mono", scale = 1.2,       weight = "Medium" },
  "MartianMono Nerd Font Mono",
  "ComicShannsMono Nerd Font Mono",
})

-- 字体 https://github.com/wez/wezterm/issues/3774
-- config.front_end = "WebGpu" -- WebGpu/OpenGL
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.freetype_load_flags = "NO_HINTING"
-- config.cell_width = 1.0

config.color_scheme = "Tokyo Night"
-- config.colors = require("themes/cyberdream")
config.window_decorations = "RESIZE"

config.native_macos_fullscreen_mode = false

config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.window_background_opacity = 0.8
config.macos_window_background_blur = 64

config.background = {
  {
    source = {
      File = "/Users/" .. os.getenv("USER") .. "/.local/share/chezmoi/dot_config/wezterm/images/Sand.jpg",
    },
    -- The texture tiles vertically but not horizontally.
    -- When we repeat it, mirror it so that it appears "more seamless".
    -- An alternative to this is to set `width = "100%"` and have
    -- it stretch across the display
    repeat_x = "Mirror",
    opacity = 0.8,
    hsb = { brightness = 0.6 },
    -- When the viewport scrolls, move this layer 10% of the number of
    -- pixels moved by the main viewport. This makes it appear to be
    -- further behind the text.
    attachment = { Parallax = 0.1 },
  },
}
config.adjust_window_size_when_changing_font_size = false
config.term = "xterm-256color"
config.default_cursor_style = "BlinkingBar"
-- config.line_height = 1.0
config.initial_rows = 38
config.initial_cols = 155
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.leader = { key = 'a', mods = 'CTRL' }
config.keys = {
  k.cmd_key(".", k.multiple_actions(":ZenMode")),

  -- 跳回 跳进
  k.cmd_key("[", act.SendKey({ mods = "CTRL", key = "o" })),
  k.cmd_key("]", act.SendKey({ mods = "CTRL", key = "i" })),

  k.cmd_key("i", k.multiple_actions(":SmartGoTo")),

  -- 将 CMD + jkhl 绑定到 CTRL + jkhl 切换窗口
  k.cmd_key("J", act.SendKey({ mods = "CTRL", key = "j" })),
  k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
  k.cmd_key("H", act.SendKey({ mods = "CTRL", key = "h" })),
  k.cmd_key("L", act.SendKey({ mods = "CTRL", key = "l" })),

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
  k.cmd_to_tmux_prefix("x", "x"),
  k.cmd_to_tmux_prefix(",", ","),

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
  -- kill the current tmux pane out of the tmux window
  {
    mods = "CMD",
    key = "x",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "x" }),
    }),
  },
}
return config
