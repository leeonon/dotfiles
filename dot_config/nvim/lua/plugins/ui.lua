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
}
