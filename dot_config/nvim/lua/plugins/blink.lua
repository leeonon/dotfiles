return {
  -- https://github.com/Saghen/blink.cmp/discussions/620
  {
    "saghen/blink.cmp",
    enabled = false,
    opts = {
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
        menu = {
          enabled = true,
          min_width = 15,
          max_height = 10,
          border = {
            { "󱐋", "WarningMsg" },
            { "─" },
            { "╮" },
            { "│" },
            { "╯" },
            { "─" },
            { "╰" },
            { "│" },
          },
        },
        documentation = {
          window = {
            border = {
              { "󰙎", "DiagnosticHint" },
              { "─" },
              { "╮" },
              { "│" },
              { "╯" },
              { "─" },
              { "╰" },
              { "│" },
            },
          },
        },
      },
    },
  },
}
