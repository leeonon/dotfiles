return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    require("flutter-tools").setup({
      dev_log = {
        enabled = false,
      },
      dev_tools = {
        autostart = true,
        auto_openbrowser = true,
      },
      debugger = {
        exception_breakpoints = {},
        enable = true,
        -- run_via_dap = false, -- 只 attach, 不 run
      },
      outline = {
        open_cmd = "40vnew", -- 打开大纲的窗口命令
        auto_open = false, -- 打开 Dart 文件时自动弹
      },
      widget_guides = { enabled = true, debug = false },
      lsp = {
        color = {
          enabled = true,
          background = true,
          virtual_text = true,
          virtual_text_str = "■",
        },
        autostart = true,
        settings = {
          -- 配置 https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
          -- 基于 项目 analysis_options.yaml formatter.page_with 配置的格式化模式需要 Dart >= 3.7 才支持
          lineLength = 120,
          showTodos = false,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
          completeFunctionCalls = true,
          -- 让分析器忽略指定目录，减少索引开销。这里忽略的是本地 pub 包缓存目录。
          analysisexcludedfolders = { vim.fn.expand("$Home/.pub-cache") },
        },
      },
      closing_tags = {
        -- highlight = "ErrorMsg",
        prefix = ">>",
        priority = 10,
        enabled = true,
      },
    })
  end,
}
