return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    enabled = true,
    lazy = true,
    event = "BufEnter",
    opts = {
      suggestion = {
        -- enabled = not vim.g.ai_cmp,
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = false,
        help = true,
      },
    },
  },
}
