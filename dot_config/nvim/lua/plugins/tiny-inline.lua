-- 同步修改 vim.diagnostic.config({ virtual_text = false })
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  enabled = false,
  config = function()
    require("tiny-inline-diagnostic").setup()
  end,
}
