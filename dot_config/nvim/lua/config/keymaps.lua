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

-- lspsaga key map
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {
  desc = "💢 Prev Diagnostic",
})
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", {
  desc = "💢 Next Diagnostic",
})
keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", {
  desc = "🔖 Lspaga Outline",
})
-- keymap.set('n', '<leader>t', '<cmd>Lspsaga term_toggle<cr>', {
--   desc = "🖥️ Lspaga 终端",
-- })
-- 全局搜索
keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", {
  desc = "🔍 全局搜索",
})

keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", {  desc = "Open Diffview" })
keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", {  desc = "Close Diffview" })
keymap.set("n", "<leader>gp", "<cmd>DiffviewFileHistory<CR>", {  desc = "DiffviewFileHistory" })

-- legendary

local legendary = require("legendary")
legendary.keymaps({
  {
    description = "Line: duplicate up",
    mode = { "n" },
    "<S-A-Up>",
    "<CMD>LineDuplicate -1<CR>",
  },
  {
    description = "Line: duplicate down",
    mode = { "n" },
    "<S-A-Down>",
    "<CMD>LineDuplicate +1<CR>",
  },
  {
    description = "Selection: duplicate up",
    mode = { "v" },
    "<S-A-Up>",
    "<CMD>VisualDuplicate -1<CR>",
  },
  {
    description = "Selection: duplicate down",
    mode = { "v" },
    "<S-A-Down>",
    "<CMD>VisualDuplicate +1<CR>",
  },
})
