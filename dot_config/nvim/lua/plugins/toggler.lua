-- 快速切换

return {
  "rmagatti/alternate-toggler",
  opts = function(_, opts)
    opts.aalternates = {
      ["=="] = "!=",
      ["true"] = "false",
      ["==="] = "!==",
      ["error"] = "warn",
    }
  end,
}
