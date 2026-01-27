return {
  "mcauley-penney/visual-whitespace.nvim",
  enabled = true,
  config = true,
  event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
  opts = {
    enabled = true,
    highlight = { link = "Visual", default = true },
  },
}
