return {
  "bassamsdata/namu.nvim",
  opts = {
    global = {},
    namu_symbols = { -- Specific Module options
      options = {},
    },
  },
  config = function()
    local namu = require("namu.namu_symbols")
    local colorscheme = require("namu.colorscheme")
    vim.keymap.set("n", "<leader>cb", namu.show, {
      desc = "Jump to LSP symbol",
      silent = true,
    })
    vim.keymap.set("n", "<leader>th", colorscheme.show, {
      desc = "Colorscheme Picker",
      silent = true,
    })
  end,
}
