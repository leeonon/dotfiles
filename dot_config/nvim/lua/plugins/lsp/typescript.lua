return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local api = require("typescript-tools.api")
    require("typescript-tools").setup({
      handlers = {
        -- 过滤诊断信息，排除特定的诊断代码
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 6133 }),
      },
      settings = {
        tsserver_file_preferences = {
          -- 设置 tsserver 文件偏好，使用非相对路径的模块导入
          importModuleSpecifierPreference = "non-relative",
        },
      },
    })
    local autocmd = vim.api.nvim_create_autocmd
    -- 在保存文件之前执行的操作
    autocmd("BufWritePre", {
      pattern = "*.ts,*.tsx,*.jsx,*.js",
      callback = function(args)
        vim.cmd("TSToolsAddMissingImports sync")        --  添加缺失的导入
        vim.cmd("TSToolsOrganizeImports sync")          -- 组织导入顺序
        require("conform").format({ bufnr = args.buf }) -- 使用 conform 格式化文件
      end,
    })
  end,
}
