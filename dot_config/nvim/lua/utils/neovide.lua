if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
  -- vim.o.guifont = "BlexMono Nerd Font Mono:h14"
  -- vim.o.guifont = "ComicShannsMono Nerd Font:h15"
  -- vim.o.guifont = "MartianMono Nerd Font Mono:13"
  -- vim.o.guifont = "GeistMono Nerd Font:14"
  vim.opt.linespace = 6 -- 行间距
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  --
  -- -- 没有空闲(动画优化)
  vim.g.neovide_no_idle = true
  -- 如果设置为true，则退出时若有未保存的更改则需要确认。默认启用。
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_fullscreen = false
  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_floating_shadow = true
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
  --
  -- 允许在neovim中进行剪贴板复制粘贴
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end
