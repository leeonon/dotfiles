-- 高亮缩进线
return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
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
