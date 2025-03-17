-- 键绑定配置在 keymaps.lua 中
return {
  "aidancz/buvvers.nvim",
  config = function()
    require("buvvers").setup({
      name_prefix = function(buffer_handle)
        return "○ "
      end,
    })
  end,
}
