return {
  "svampkorg/moody.nvim",
  event = { "ModeChanged" },
  dependencies = {
    -- or wherever you setup your HL groups :)
    "catppuccin/nvim",
  },
  opts = {
    -- you can set different blend values for your different modes.
    -- Some colours might look better more dark.
    blend = {
      normal = 0.2,
      insert = 0.2,
      visual = 0.3,
      command = 0.2,
      replace = 0.2,
      select = 0.3,
      terminal = 0.2,
      terminal_n = 0.2,
    },
  },
}
