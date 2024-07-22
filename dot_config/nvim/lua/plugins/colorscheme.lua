-- https://github.com/catppuccin/nvim/discussions/323
-- lazy = false 可以编辑器中 <leader>uC 快速切换
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "savq/melange-nvim" },
  {
    "rebelot/kanagawa.nvim",
  },
  { "Shatur/neovim-ayu" },
  -- catppuccin
  -- 社区配置分享：https://github.com/catppuccin/nvim/discussions/323?sort=new
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      term_colors = true,
      transparent_background = true,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          rosewater = "#ffc9c9",
          flamingo = "#ff9f9a",
          pink = "#ffa9c9",
          mauve = "#df95cf",
          lavender = "#a990c9",
          red = "#ff6960",
          maroon = "#f98080",
          peach = "#f9905f",
          yellow = "#f9bd69",
          green = "#b0d080",
          teal = "#a0dfa0",
          sky = "#a0d0c0",
          sapphire = "#95b9d0",
          blue = "#89a0e0",
          text = "#e0d0b0",
          subtext1 = "#d5c4a1",
          subtext0 = "#bdae93",
          overlay2 = "#928374",
          overlay1 = "#7c6f64",
          overlay0 = "#665c54",
          surface2 = "#504844",
          surface1 = "#3a3634",
          surface0 = "#252525",
          base = "#151515",
          mantle = "#0e0e0e",
          crust = "#080808",
        },
      },
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        styles = {
          sidebars = "transparent",
        },
      }
    end,
  },
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      comment = {
        italic = true,
      },
      styles = {
        transparent = true,
        booleans = { bold = true },
        functions = { italic = true },
        comments = { italic = true },
      },
    },
  },
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_transparent_background = true
      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_diagnostic_virtual_text = "highlighted"
      vim.g.everforest_background = "hard"
      vim.g.everforest_ui_contrast = "high"
      vim.g.everforest_current_word = "underline"
    end,
  },
  {
    "mellow-theme/mellow.nvim",
  },
  {
    "0xstepit/flow.nvim",
    name = "Flow",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("flow").setup_options({
        transparent = true, -- Set transparent background.
        fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
        mode = "normal", -- Intensity of the palette: normal, dark, or bright. Notice that dark is ugly!
        aggressive_spell = false, -- Display colors for spell check.
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "solarized-osaka",
      -- colorscheme = "catppuccin",
      -- colorscheme = "melange",
      -- colorscheme = "kanagawa",
      -- colorscheme = "gruvbox",
      -- colorscheme = "citruszest",
      -- colorscheme = "night-owl",
      -- colorscheme = "everforest",
      -- colorscheme = "aylin",
      -- colorscheme = "solarized",
      -- colorscheme = "ayu-mirage",
      -- colorscheme = "oldworld",
      colorscheme = "flow",
      -- colorscheme = "mellow",
    },
  },
}
