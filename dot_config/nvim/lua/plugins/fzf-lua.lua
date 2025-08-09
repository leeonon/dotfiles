-- 暂时使用 snacks picker 代替
return {
  "ibhagwan/fzf-lua",
  enabled = false,
  opts = function(_, opts)
    opts.winopts = {
      backdrop = 100,
      preview = {
        -- vertical = "up:55%",
        -- layout = "vertical",
      },
    }
  end,
}
