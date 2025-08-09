return {
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig", -- optional
    },
    keys = {
      { "<leader>tt", "<cmd>TailwindConcealToggle<cr>", desc = "切换tailwind css 显示" },
    },
    opts = {
      document_color = {
        enabled = true,
        kind = "foreground", -- "inline" | "foreground" | "background"
        inline_symbol = "", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = true, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
    }, -- your configuration
    config = function()
      require("tailwind-tools").setup({
        server = {
          settings = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
              eruby = "erb",
            },
          },
        },
        document_color = {
          -- disable, to allow nvim-highlight-colors to add colors
          -- for tailwind classes.
          enabled = false,
        },
      })
    end,
  },
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>tv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
    },
    opts = {
      border = "rounded", -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
      focus_preview = true, -- Sets the preview as the current window
      copy_register = "", -- The register to copy values to,
      keymaps = {
        copy = "<C-y>", -- Normal mode keymap to copy the CSS values between {}
      },
    },
  },
}
