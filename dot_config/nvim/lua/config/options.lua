-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 拼写检查
-- vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.g.transparent_background = true
vim.g.autoformat = false

-- 自动缩进
vim.opt.autoindent = true
-- 智能缩进
vim.opt.smartindent = true
-- 光标上下至少10行距离
vim.opt.scrolloff = 10

vim.opt.shiftwidth = 2
-- 配置 backspace 键的行为，允许删除行首、行尾和缩进。
vim.opt.backspace = { "start", "eol", "indent" }
-- 忽略 node_modules 目录中的文件。
vim.opt.wildignore:append({ "*/node_modules/*" })

-- 在块注释中自动插入 * 号。
vim.opt.formatoptions:append({ "r" })

vim.opt.laststatus = 3

-- 启用真色彩
vim.opt.termguicolors = true
-- 自动同步缓冲区
vim.opt.autoread = true
-- 禁用 neovim 生成交换文件并显示错误
vim.opt.swapfile = false
