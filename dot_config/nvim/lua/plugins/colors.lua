return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    keys = {
      { "<leader>co", "<cmd>HighlightColors toggle<CR>" },
    },
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_tailwind = true,
      })
      require("nvim-highlight-colors").turnOn()
    end,
  },
}
