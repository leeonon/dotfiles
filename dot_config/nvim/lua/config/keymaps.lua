-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- https://github.com/craftzdog/dotfiles-public/blob/0ea8ead000014cd71ae0a429cc6cf87468974732/.config/nvim/lua/config/keymaps.lua
-- local discipline = require("utils.discipline")
-- discipline.cowboy()
--
local keymap = vim.keymap

-- 删除默认的键映射

keymap.set("i", "jk", "<Esc>")
keymap.set("n", "<c-a>", "ggVG")

keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>x", "<cmd>x<cr>")

-- 快速切换插件
keymap.set("n", "<leader>i", "<cmd>ToggleAlternate<cr>")

keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
keymap.set("n", "<leader>gp", "<cmd>DiffviewFileHistory<CR>", { desc = "DiffviewFileHistory" })

-- 避免使用 Ctrl + a 和 Ctrl + x, 会不小心触发数字增减
keymap.set("n", "<C-a>", "<Nop>")
keymap.set("n", "<C-x>", "<Nop>")

-- legendary 多行复制移动
keymap.set("n", "<S-A-Up>", "<CMD>LineDuplicate -1<CR>", { desc = "Line: duplicate up" })
keymap.set("n", "<S-A-Down>", "<CMD>LineDuplicate +1<CR>", { desc = "Line: duplicate down" })
keymap.set("v", "<S-A-Up>", "<CMD>VisualDuplicate -1<CR>", { desc = "Selection: duplicate up" })
keymap.set("v", "<S-A-Down>", "<CMD>VisualDuplicate +1<CR>", { desc = "Selection: duplicate down" })
