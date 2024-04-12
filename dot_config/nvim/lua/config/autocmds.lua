-- Autocmds会在VeryLazy事件上自动加载
-- 默认设置的autocmds：https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- 在这里添加任何额外的autocmds

-- 禁用某些文件格式中的隐藏功能
-- The default conceallevel is 3 in LazyVim
-- 文件不自动隐藏双引号
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})
