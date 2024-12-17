return {
  {
    "saghen/blink.cmp",
    enabled = true,
    opts = {
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
      },
    },
  },
}
