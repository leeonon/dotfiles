-- https://meatfighter.com/ascii-silhouettify/color-gallery.html
return {
  -- 窗口设置
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>;m", "<cmd>MaximizerToggle<CR>", desc = "最大化/最小化分割窗口" },
    },
  },
  -- LSP Hover Doc 边框设置
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
      -- 禁用显示“无可用消息”提示
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- 展示尾随空格
  -- {
  --   "johnfrankmorgan/whitespace.nvim",
  -- },
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   opts = function()
  --     -- local opts = {
  --     --   theme = "hyper",
  --     --   hide = {
  --     --     statusline = false,
  --     --   },
  --     --   config = {
  --     --     packages = { enable = true },
  --     --     week_header = {
  --     --       enable = true,
  --     --     },
  --     --     shortcut = {
  --     --       {
  --     --         icon = " ",
  --     --         icon_hl = "@variable",
  --     --         desc = "Files",
  --     --         group = "Label",
  --     --         action = "Telescope find_files",
  --     --         key = "f",
  --     --       },
  --     --       { action = "Lazy", group = "@property", desc = " Lazy", icon = "󰒲 ", key = "l" },
  --     --       { action = "LazyExtras", group = "DiagnosticHint", desc = " Lazy Extras", icon = " ", key = "x" },
  --     --       { action = "Telescope live_grep", group = "Number", desc = " Find Text", icon = " ", key = "g" },
  --     --       { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
  --     --       { action = "qa", desc = " Quit", icon = " ", key = "q" },
  --     --     },
  --     --     footer = function()
  --     --       local stats = require("lazy").stats()
  --     --       local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --     --       return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
  --     --     end,
  --     --   },
  --     -- }
  --     -- return opts
  --   end,
  -- },
}
