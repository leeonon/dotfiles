return {
  "gen740/SmoothCursor.nvim",
  enabled = true,
  config = function()
    require("smoothcursor").setup({
      cursor = "👉",
      fancy = {
        enable = true,
        head = { cursor = "👉" },
      },
    })
  end,
}
