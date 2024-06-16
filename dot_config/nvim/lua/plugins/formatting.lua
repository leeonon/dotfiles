-- conform 格式化配置
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
    },
  },
}

-- return {
--   "stevearc/conform.nvim",
--   config = function()
--     local conform = require("conform")
--
--     conform.setup({
--       formatters_by_ft = {
--         javascript = { "prettier" },
--         typescript = { "prettier" },
--         javascriptreact = { "prettier" },
--         typescriptreact = { "prettier" },
--         svelte = { "prettier" },
--         css = { "prettier" },
--         html = { "prettier" },
--         json = { "prettier" },
--         yaml = { "prettier" },
--         markdown = { "prettier" },
--         graphql = { "prettier" },
--         liquid = { "prettier" },
--         lua = { "stylua" },
--         python = { "isort", "black" },
--       },
--       format_on_save = {
--         lsp_fallback = true, -- 如果当前文件没有找到格式化程序，则回退到使用 LSP 提供的格式化功能。
--         async = false, -- 同步方式执行格式化。即格式化操作完成后才继续执行后续命令。
--         timeout_ms = 1000, -- 格式化操作的超时时间
--       },
--     })
--
--     vim.keymap.set({ "n", "v" }, "<leader>mp", function()
--       conform.format({
--         lsp_fallback = true,
--         async = false,
--         timeout_ms = 1000,
--       })
--     end, { desc = "格式化文件或范围(在可视模式下)" })
--   end,
-- }
--
