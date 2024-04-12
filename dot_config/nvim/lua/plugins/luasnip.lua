return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./lua/utils/snippets" } }) -- load snippets paths
  end,
}
