return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        chars = {
          -- horizontal_line = "─",
          -- vertical_line = "│",
          -- left_top = "┌",
          -- left_bottom = "└",
          -- right_arrow = "─",
        },
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
        enable = false,
      },
    })
  end,
}
