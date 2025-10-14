return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    require("flutter-tools").setup({
      debugger = {
        exception_breakpoints = {},
      },
      outline = { auto_open = false },
      decorations = {
        statusline = { device = true, app_version = true },
      },
      widget_guides = { enabled = true, debug = false },
      lsp = {
        color = {
          enabled = true,
          background = true,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          showTodos = false,
          renameFilesWithClasses = "always",
          updateImportsOnRename = true,
          completeFunctionCalls = true,
          lineLength = 100,
        },
      },
      closing_tags = {
        highlight = "ErrorMsg",
        prefix = ">",
        priority = 10,
        enabled = false,
      },
    })
  end,
}
