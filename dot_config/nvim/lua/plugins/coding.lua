return {
  -- 重命名高亮 <leader>cr
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  -- jsdoc
  {
    "kkoomen/vim-doge",
    event = "BufRead",
    keys = {
      {
        "<leader>d",
        "<cmd>DogeGenerate<CR>",
        desc = "🐕 Doc",
      },
    },
    config = function()
      vim.cmd([[call doge#install()]])
    end,
  },
}
