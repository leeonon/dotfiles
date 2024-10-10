-- 参考https://github.com/mvpopuk/dotfiles/blob/main/nvim/lua/plugins/git.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    -- opts = {
    --   setup = function()
    --     vim.keymap.set("n","<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
    --   end,
    -- },
  },
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- not git, but it's okay
  "mbbill/undotree",
}
