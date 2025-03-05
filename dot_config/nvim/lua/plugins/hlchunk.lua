return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        chars = {
          horizontal_line = "┅",
          left_top = "┏",
          vertical_line = "┇",
          left_bottom = "┗",
          right_arrow = "┅",
        },
        -- style = "#806d9c",
        style = "#00ffff",
      },
      indent = {
        enable = false,
      },
      blank = {
        enable = false,
        chars = {
          "⁙",
        },
      },
      line_num = {
        style = "#806d9c",
        enable = true,
      },
    })
  end,
}
