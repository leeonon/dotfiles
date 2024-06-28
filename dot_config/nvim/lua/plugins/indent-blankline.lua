return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  enabled = false,
  show_start = true,
  show_end = false,
  injected_languages = false,
  highlight = { "Function", "Label" },
  config = function(_)
    require("ibl").setup({})
  end,
}
