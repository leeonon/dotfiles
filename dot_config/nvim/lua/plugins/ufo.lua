return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  config = function()
    require("ufo").setup({
      provider_selector = function()
        return { "lsp", "indent" }
      end,
    })
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open all folds except current fold" })
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close all folds with current fold" })
    vim.keymap.set("n", "zk", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek folded lines under cursor" })
  end,
}
