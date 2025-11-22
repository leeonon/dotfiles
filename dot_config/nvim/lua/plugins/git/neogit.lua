return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-mini/mini.pick", -- optional
    "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
  coding = function()
    require("neogit").setup({
      integrations = {
        fzf_lua = false,
        snacks = true,
      },
    })
  end,
}
