return {
  "developedbyed/marko.nvim",
  enabled = true,
  config = function()
    require("marko").setup({
      width = 100,
      height = 100,
      border = "rounded",
      title = " Marks ",
    })
  end,
}
