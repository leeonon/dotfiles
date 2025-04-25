-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- https://github.com/craftzdog/dotfiles-public/blob/0ea8ead000014cd71ae0a429cc6cf87468974732/.config/nvim/lua/config/keymaps.lua
-- local discipline = require("utils.discipline")
-- discipline.cowboy()
--
local keymap = vim.keymap
local MiniBufremove = require("mini.bufremove")

-- 删除默认的键映射

keymap.set("i", "jk", "<Esc>")
keymap.set("n", "<c-a>", "ggVG")
-- 复制一行并注释掉第一行
keymap.set("n", "yc", "yygccp")
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

-- hinell/duplicate.nvim 多行复制移动
keymap.set("n", "<S-A-Up>", "<CMD>LineDuplicate -1<CR>", { desc = "Line: duplicate up" })
keymap.set("n", "<S-A-Down>", "<CMD>LineDuplicate +1<CR>", { desc = "Line: duplicate down" })
keymap.set("v", "<S-A-Up>", "<CMD>VisualDuplicate -1<CR>", { desc = "Selection: duplicate up" })
keymap.set("v", "<S-A-Down>", "<CMD>VisualDuplicate +1<CR>", { desc = "Selection: duplicate down" })

-- 搜索
keymap.set("n", "<S-F>", function()
  local grug = require("grug-far")
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Lens" })

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("buvvers_keymap", { clear = true }),
  pattern = "BuvversAttach",
  callback = function()
    vim.keymap.set("n", "d", function()
      local current_buf_handle = require("buvvers").get_current_buf_handle()
      MiniBufremove.delete(current_buf_handle, false)
    end, {
      buffer = require("buvvers").get_buvvers_buf_handle(),
      nowait = true,
    })
    vim.keymap.set("n", "o", function()
      local current_buf_handle = require("buvvers").get_current_buf_handle()
      local previous_win_handle = vim.fn.win_getid(vim.fn.winnr("#"))
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/0b44040ec7b8472dfc504bbcec735419347797ad/lua/neo-tree/utils/init.lua#L643
      vim.api.nvim_win_set_buf(previous_win_handle, current_buf_handle)
      vim.api.nvim_set_current_win(previous_win_handle)
    end, {
      buffer = require("buvvers").get_buvvers_buf_handle(),
      nowait = true,
    })
  end,
})

-- legendary.nvim
keymap.set("n", "<leader>le", "<cmd>Legendary<cr>", { desc = "Legendary" })

-- 复制一行并注释掉第一行
keymap.set("n", "ycc", "yygccp", { remap = true })
-- 在 INSERT 和 NORMAL 模式下自动在行尾添加分号或逗号
keymap.set("i", ";;", "<ESC>A;")
keymap.set("i", ",,", "<ESC>A,")
keymap.set("n", ";;", "A;<ESC>")
keymap.set("n", ",,", "A,<ESC>")

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

keymap.set("v", "<leader>wd", 'xi""<ESC>hp', { desc = "用双引号包裹选定文本" })
keymap.set("v", "<leader>ws", "xi''<ESC>hp", { desc = "用单引号包裹选定文本" })

keymap.set("n", "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
