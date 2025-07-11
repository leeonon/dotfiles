return {
  "bassamsdata/namu.nvim",
  config = function()
    require("namu").setup({
      namu_symbols = {
        enable = true,
        options = {
          -- here you can configure namu
          movement = {
            next = "<C-j>",
            previous = "<C-k>",
            alternative_next = "<DOWN>",
            alternative_previous = "<UP>",
          },
        },
      },
      -- Optional: Enable other modules if needed
      colorscheme = {
        enable = false,
        options = {
          -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
          persist = true, -- very efficient mechanism to Remember selected colorscheme
          write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
        },
      },
      ui_select = { enable = false }, -- vim.ui.select() wrapper
    })
    -- === Suggested Keymaps: ===
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
