-- rust debug https://www.bilibili.com/video/BV1rf421S7ey
return {
  -- rustaceanvim 与 nvim-lspconfig 中的 rust-analyzer 有冲突, 暂时用不上 rustaceanvim
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4", -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
}
