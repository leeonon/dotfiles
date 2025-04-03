return {
  "ibhagwan/fzf-lua",
  enabled = true,
  opts = function(_, opts)
    opts.winopts = {
      backdrop = 100,
      preview = {
        vertical = "up:55%",
        layout = "vertical",
      },
    }
  end,
}
