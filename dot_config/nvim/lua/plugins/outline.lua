local icons = require("icons.icons")

return {
  {
    "stevearc/aerial.nvim",
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
      close_automatic_events = {
        -- "unfocus",
        -- "switch_buffer",
      },
      guides = {
        nested_top = " │ ",
        mid_item = " ├─",
        last_item = " └─",
        whitespace = "   ",
      },
      layout = {
        placement = "window",
        close_on_select = false,
        max_width = 50,
        min_width = 30,
      },
      ignore = {
        buftypes = {},
      },
      icons = icons,
      show_guides = true,
      -- open_automatic = function()
      --   local aerial = require("aerial")
      --   return vim.api.nvim_win_get_width(0) > 80 and not aerial.was_closed()
      -- end,
    },
    config = function(_, opts)
      require("aerial").setup(opts)
      vim.keymap.set("n", "<leader>cs", "<cmd>AerialToggle!<cr>", { silent = true })
    end,
  },
  -- {
  --   "hedyhli/outline.nvim",
  --   keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
  --   cmd = "Outline",
  --   opts = function()
  --     -- local defaults = require("outline.config").defaults
  --     -- local opts = {
  --     --   symbols = {
  --     --     icons = {},
  --     --     -- filter = vim.deepcopy(LazyVim.config.kind_filter),
  --     --   },
  --     --   keymaps = {
  --     --     up_and_jump = "<up>",
  --     --     down_and_jump = "<down>",
  --     --   },
  --     -- }
  --     --
  --     -- for kind, symbol in pairs(defaults.symbols.icons) do
  --     --   opts.symbols.icons[kind] = {
  --     --     icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
  --     --     hl = symbol.hl,
  --     --   }
  --     -- end
  --     -- return opts
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    optional = true,
    keys = {
      { "<leader>cs", false },
    },
  },
}
