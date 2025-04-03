-- https://github.com/catppuccin/nvim/discussions/323
-- lazy = false 可以编辑器中 <leader>uC 快速切换
return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
    end,
  },
  {
    lazy = false,
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      local theme = require("tokyonight")
      theme.setup({
        style = "night",
        transparent = true,
        on_colors = function()
          -- colors.bg_visual = M.colors.grey12
        end,
        styles = {
          comments = { italic = true },
          sidebars = "transparent",
        },
      })
      -- theme.load()
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
      opts.transparent = true
      opts.italic_comments = true
      opts.borderless_pickers = false
    end,
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    tag = "v2.0.0",
    opts = {
      -- Your configuration options here.
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, or dawn
        dark_variant = "dawn", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },

        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
        end,
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = function()
      return {
        undercurl = false,
        commentStyle = { italic = true },
        keywordStyle = { italic = false },
        statementStyle = { italic = false, bold = false },
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,
      }
    end,
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
          base = "#151515",
          mantle = "#0e0e0e",
          crust = "#080808",
        },
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
      -- vim.g.everforest_current_word = "underline"
    end,
  },
  {
    "bettervim/yugen.nvim",
    config = function() end,
  },
  { "nuvic/flexoki-nvim", as = "flexoki" },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function() end,
  },
  {
    "comfysage/evergarden",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      theme = {
        variant = "fall", -- 'winter'|'fall'|'spring'
        accent = "green",
      },
      editor = {
        transparent_background = false,
        sign = { color = "none" },
        float = {
          color = "mantle",
          invert_border = false,
        },
        completion = {
          color = "surface0",
        },
      },
      style = {
        tabline = { "reverse" },
        search = { "italic", "reverse" },
        incsearch = { "italic", "reverse" },
        types = { "italic" },
        keyword = { "italic" },
        comment = { "italic" },
      },
      overrides = {},
      color_overrides = {},
    },
  },
  {
    "comfysage/gruvboxed",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      transparent_background = true,
      contrast_dark = "medium",
      style = {
        tabline = { reverse = true, color = "green" },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = false },
        comment = { italic = true },
      },
    },
  },
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "bright"
      vim.g.gruvbox_material_statusline_style = "material"
      vim.g.gruvbox_material_cursor = "auto"

      -- vim.g.gruvbox_material_colors_override = { bg0 = '#16181A' } -- #0e1010
      -- vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("oldworld").setup({
        variant = "default", -- default, oled, cooler
        styles = {
          comments = { italic = true },
        },
      })
    end,
  },
  {
    "timmypidashev/darkbox.nvim",
    lazy = false,
    config = function() end,
  },
  {
    "wtfox/jellybeans.nvim",
    priority = 1000,
    config = function()
      -- require("jellybeans").setup()
    end,
  },
  {
    "rjshkhr/shadow.nvim",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
    end,
  },
  {
    "nordtheme/vim",
    priority = 1000,
    config = function() end,
  },
  {

    "rmehri01/onenord.nvim",
    priority = 1000,
    config = function()
      -- require("onenord").setup({
      --   theme = nil, -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
      --   borders = true, -- Split window borders
      --   fade_nc = false, -- Fade non-current windows, making them more distinguishable
      --   -- Style that is applied to various groups: see `highlight-args` for options
      --   styles = {
      --     comments = "NONE",
      --     strings = "NONE",
      --     keywords = "NONE",
      --     functions = "NONE",
      --     variables = "NONE",
      --     diagnostics = "underline",
      --   },
      --   disable = {
      --     background = true, -- Disable setting the background color
      --     float_background = false, -- Disable setting the background color for floating windows
      --     cursorline = false, -- Disable the cursorline
      --     eob_lines = true, -- Hide the end-of-buffer lines
      --   },
      --   -- Inverse highlight for different groups
      --   inverse = {
      --     match_paren = false,
      --   },
      --   custom_highlights = {}, -- Overwrite default highlight groups
      --   custom_colors = {}, -- Overwrite default colors
      -- })
    end,
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
      transparent_background = true,
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyodark",
      -- colorscheme = "oldworld",
      -- colorscheme = "darkbox",
      -- colorscheme = "jellybeans",
      -- colorscheme = "gruvbox-material",
      -- colorscheme = "catppuccin",
      -- colorscheme = "kanagawa",
      -- colorscheme = "gruvbox",
      -- colorscheme = "citruszest",
      -- colorscheme = "everforest",
      -- colorscheme = "ayu",
      -- colorscheme = "rose-pine",
      -- colorscheme = "tokyonight",
      -- colorscheme = "four-symbols",
      -- colorscheme = "evergarden",
      -- colorscheme = "gruvboxed",
      -- colorscheme = "nord",
      -- colorscheme = "miasma",
      -- colorscheme = "flow",
      -- colorscheme = "moonfly",
      -- colorscheme = "shadow",
      -- colorscheme = "onenord",
    },
  },
}
