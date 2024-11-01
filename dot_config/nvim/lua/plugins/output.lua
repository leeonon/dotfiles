-- 用于查看来自 LSP 服务器日志的面板
-- :OutputPanel 切换面板
return {
  "mhanberg/output-panel.nvim",
  event = "VeryLazy",
  config = function()
    require("output_panel").setup()
  end,
}
