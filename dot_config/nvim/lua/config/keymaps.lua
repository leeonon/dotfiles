-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- https://github.com/craftzdog/dotfiles-public/blob/0ea8ead000014cd71ae0a429cc6cf87468974732/.config/nvim/lua/config/keymaps.lua
-- local discipline = require("utils.discipline")
-- discipline.cowboy()
--
local keymap = vim.keymap

keymap.set("n", "\\", "<CMD>:sp<CR>", { desc = "Split window horizontally" })
keymap.set("n", "|", "<CMD>:vsp<CR>", { desc = "Split window vertically" })

keymap.set("i", "jk", "<Esc>")
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move cursor down" })
keymap.set("x", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move cursor down" })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move cursor up" })
keymap.set("x", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move cursor up" })

-- 跳转当改行最后一个字符 默认为 $
keymap.set("n", "gl", "$", { desc = "Go to line end" })
-- 跳转到行首
keymap.set("n", "gh", "^", { desc = "Go to line start" })
-- 跳转到下面的 markdown 标题
keymap.set("n", "gj", "<cmd>call search('^#', 'W')<cr>", { desc = "Go to next markdown header" })
-- 跳转到上面的 markdown 标题
keymap.set("n", "gk", "<cmd>call search('^#', 'bW')<cr>", { desc = "Go to previous markdown header" })

-- keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
-- keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- 复制一行并注释掉第一行
keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>x", "<cmd>x<cr>")

-- 选中整个文件 - vig
-- 复制整个文件 - yig
keymap.set("n", "<leader>i", ":Neotree filesystem reveal float<CR>", {})

keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
keymap.set("n", "<leader>gp", "<cmd>DiffviewFileHistory<CR>", { desc = "DiffviewFileHistory" })

-- 避免使用 Ctrl + a 和 Ctrl + x, 会不小心触发数字增减
keymap.set("n", "<C-a>", "<Nop>")
keymap.set("n", "<C-x>", "<Nop>")

-- hinell/duplicate.nvim 多行复制移动
keymap.set("n", "<S-A-Up>", "<CMD>LineDuplicate -1<CR>", { desc = "Line: duplicate up" })
keymap.set("n", "<S-A-Down>", "<CMD>LineDuplicate +1<CR>", { desc = "Line: duplicate down" })
keymap.set("v", "<S-A-Up>", "<CMD>VisualDuplicate -1<CR>", { desc = "Selection: duplicate up" })
keymap.set("v", "<S-A-Down>", "<CMD>VisualDuplicate +1<CR>", { desc = "Selection: duplicate down" })

-- 行号
keymap.set("n", "<leader>ul", function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = false
  else
    vim.wo.relativenumber = true
    vim.wo.number = true
  end
end, { desc = "Toggle Line Numbers" })

-- 复制一行并注释掉第一行
keymap.set("n", "ycc", "yygccp", { remap = true })
-- 在 INSERT 和 NORMAL 模式下自动在行尾添加分号或逗号
keymap.set("i", ";;", "<ESC>A;")
keymap.set("i", ",,", "<ESC>A,")
keymap.set("n", ";;", "A;<ESC>")
keymap.set("n", ",,", "A,<ESC>")

-- 调整窗口大小 - Ctrl + w + = 恢复窗口大小
keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- 上下移动文本行
-- 正常模式
keymap.set("n", "<A-Down>", ":m .+1<CR>==")
keymap.set("n", "<A-Up>", ":m .-2<CR>==")
-- 插入模式
keymap.set("i", "<A-Down>", "<esc>:m .+1<CR>==gi")
keymap.set("i", "<A-Up>", "<esc>:m .-2<CR>==gi")
-- 视觉模式
keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

-- 重载 Neovim 配置
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("source $MYVIMRC")
  vim.cmd("Lazy reload")
  print("配置已重载")
end, { desc = "重载 Neovim 配置" })
