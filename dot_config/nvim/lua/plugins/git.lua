-- 参考https://github.com/mvpopuk/dotfiles/blob/main/nvim/lua/plugins/git.lua
-- https://github.com/patricorgi/dotfiles/blob/main/.config/nvim/lua/custom/plugins/gitsigns.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    event = "InsertEnter",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
      { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView History" },
    },
    specs = {
      {
        "NeogitOrg/neogit",
        optional = true,
        opts = { integrations = { diffview = true } },
      },
    },
    config = function()
      require("custom.config.diffview")
    end,
  },
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- not git, but it's okay
  "mbbill/undotree",
}
