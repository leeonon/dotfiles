-- 将绑定的快捷键转换为图形化界面，类似 VSCode Command + Shift + P 的方式
-- https://github.com/mrjones2014/legendary.nvim/blob/master/doc/EXTENSIONS.md#lazynvim
return {
  "mrjones2014/legendary.nvim",
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  config = function()
    require("legendary").setup({
      extensions = {
        lazy_nvim = true,
      },
    })
  end,
  -- sqlite is only needed if you want to use frecency sorting
  -- dependencies = { 'kkharji/sqlite.lua' }
}
