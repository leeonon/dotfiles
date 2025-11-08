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
        style = "#806d9c",
      },
      indent = {
        enable = false,
        chars = {
          "│",
          "¦",
          "┆",
          "┊",
        },
        style = {
          "#FF0000",
          "#FF7F00",
          "#FFFF00",
          "#00FF00",
          "#00FFFF",
          "#0000FF",
          "#8B00FF",
        },
      },
      blank = {
        enable = false,
        chars = {
          "⁙",
        },
      },
      line_num = {
        style = "#899d9c",
        enable = true,
      },
    })
  end,
}
