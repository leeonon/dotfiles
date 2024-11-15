-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 拼写检查
-- vim.opt.spell = false
-- vim.opt.spelllang = { "en", "cjk" }
vim.g.transparent_background = true

-- 忽略 node_modules 目录中的文件。
vim.opt.wildignore:append({ "*/node_modules/*" })
-- 在块注释中自动插入 * 号。
vim.opt.formatoptions:append({ "r" })
vim.opt.laststatus = 3
-- 自动缩进
vim.opt.autoindent = true
-- 智能缩进
vim.opt.smartindent = true
vim.cmd([[let &t_Ce = "\e[4:0m"]]) --关闭下划曲线。
-- 启用真色彩
vim.opt.termguicolors = true
-- 禁用 neovim 生成交换文件并显示错误
vim.opt.swapfile = false
-- 用于解决 neo-tree 在 monorepo 项目中切换文件时,目录发生变化的问题
-- https://github.com/LazyVim/LazyVim/discussions/2150
-- 可能会导致 lsp 服务在项目在 monorepo 项目切换时无法自动切换?
vim.g.root_spec = { "cwd" }
-- edgy.nvim
-- 默认拆分会导致在打开边栏时主拆分跳跃。
-- 为了防止这种情况,请将 `splitkeep` 设置为 `screen` 或 `topline`。
vim.opt.splitkeep = "screen"

-- diagnostic border
local _border = "single"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config({
  float = { border = _border },
  virtual_text = false,
})

vim.o.termguicolors = true
