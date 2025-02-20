return {
  "caliguIa/zendiagram.nvim",
  opts = {},
  config = function()
    require("zendiagram").setup({
      -- Below are the default values
      header = "## Diagnostics", -- Header text
      style = "default", -- Float window style - 'default' | 'compact'
      max_width = 50, -- The maximum width of the float window
      min_width = 25, -- The minimum width of the float window
      max_height = 10, -- The maximum height of the float window
      position = {
        row = 1, -- The offset from the top of the screen
        col_offset = 2, -- The offset from the right of the screen
      },
    })
    vim.keymap.set("n", "<Leader>dd", require("zendiagram").open, { silent = true, desc = "Open diagnostics float" })
  end,
}
