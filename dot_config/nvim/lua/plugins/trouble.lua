return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "打开/关闭 trouble 列表" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "打开 trouble 工作区诊断" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "打开 trouble 文档诊断" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "打开 trouble 快速修复列表" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "打开 trouble 位置列表" },
    { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "在 trouble 中打开 todos" },
  },
}
