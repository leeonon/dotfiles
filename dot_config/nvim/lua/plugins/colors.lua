return {
  -- 该插件暂时不支持 oklch 颜色空间
  -- TODO: https://github.com/brenoprata10/nvim-highlight-colors/pull/169
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    enabled = true,
    keys = {
      { "<leader>co", "<cmd>HighlightColors toggle<CR>" },
    },
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_tailwind = true,
      })
      require("nvim-highlight-colors").turnOn()
    end,
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      -- {
      --   "<leader>v",
      --   function()
      --     require("oklch-color-picker").pick_under_cursor()
      --   end,
      --   desc = "Color pick under cursor",
      -- },
    },
    opts = {},
  },
}
