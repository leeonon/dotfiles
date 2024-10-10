return {
  "gaelph/logsitter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    vim.keymap.set("n", "<leader>lg", function()
      require("logsitter").log()
    end, {
      desc = "Log current line",
    })

    -- experimental visual mode
    vim.keymap.set("x", "<leader>lg", function()
      require("logsitter").log_visual()
    end)

    require("logsitter").setup({
      path_format = "fileonly",
      prefix = "[LS] 🚀 ->",
      separator = "->",
    })
  end,
}
