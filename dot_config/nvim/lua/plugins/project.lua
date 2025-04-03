return {
  "ahmedkhalf/project.nvim",
  optional = true,
  -- <leader>fp to find project
  opts = function(_, opts)
    opts.manual_mode = false
    opts.detection_methods = { "lsp", "pattern" }
    opts.patterns = {
      ".git",
      ".hg",
      ".svn",
    }
  end,
}
