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
        enable = true,
        -- run_via_dap = false, -- 只 attach, 不 run
      },
      outline = {
        open_cmd = "30vnew", -- 打开大纲的窗口命令
        auto_open = false, -- 打开 Dart 文件时自动弹
      },
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
          showTodos = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
          completeFunctionCalls = true,
          -- 让分析器忽略指定目录，减少索引开销。这里忽略的是本地 pub 包缓存目录。
          analysisexcludedfolders = { vim.fn.expand("$Home/.pub-cache") },
          lineLength = 120,
          -- lineLength = vim.o.textwidth,
        },
      },
      closing_tags = {
        -- highlight = "ErrorMsg",
        -- prefix = ">",
        -- priority = 10,
        enabled = true,
      },
    })
  end,
}
