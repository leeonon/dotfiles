return {
  "shortcuts/no-neck-pain.nvim",
  config = function()
    require("no-neck-pain").setup({
      width = 130,
      buffers = {
        wo = {
          fillchars = "eob: ",
        },
      },
    })
  end,
}
