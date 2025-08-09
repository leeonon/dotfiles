-- https://github.com/catppuccin/nvim/discussions/323
-- lazy = false 可以编辑器中 <leader>uC 快速切换
return {
  -- add gruvbox
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      transparent_background = false,
      gamma = 1.00,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        identifiers = { italic = true },
        functions = {},
        variables = {},
      },
      custom_highlights = function()
        return {
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          FloatTitle = { bg = "NONE" },
          TabLineFill = { bg = "NONE" },
          StatusLineNC = { bg = "NONE" },
          StatusLineTermNC = { bg = "NONE" },
          TabLine = { bg = "NONE" },
        }
      end,
      custom_palette = function()
        return {
          -- bg = "NONE",
          -- bg1 = "NONE",
          bg2 = "NONE",
          -- bg3 = "NONE",
          -- bg4 = "NONE",
          -- bg5 = "NONE",
        }
      end,
      terminal_colors = true,
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = {
                bg = "none",
                bg_gutter = "none", -- set background color for gutter
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
          }
        end,
        theme = "dragon", -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
    end,
  },
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
        transparent_mode = false,
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, or dawn
        dark_variant = "dawn", -- main, moon, or dawn
        dim_inactive_windows = true, -- 非活动窗口变暗
        extend_background_behind_borders = true,

        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },

        highlight_groups = {
          Comment = { italic = true },
          VertSplit = { fg = "muted", bg = "muted" },
          Function = { italic = true },
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
      transparent_background = false,
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
      vim.g.everforest_transparent_background = false
      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_diagnostic_virtual_text = "highlighted"
      vim.g.everforest_background = "hard"
      vim.g.everforest_ui_contrast = "high"
      -- vim.g.everforest_current_word = "underline"
    end,
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
      vim.g.gruvbox_material_statusline_style = "mix" -- Options: "original", "material", "mix", "afterglow"
      vim.g.gruvbox_material_cursor = "auto"
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
          functions = { italic = true },
        },
        integrations = {
          navic = true,
          alpha = false,
          rainbow_delimiters = false,
        },
        highlight_overrides = {
          Normal = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          -- CursorLine = { bg = "#090909" },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          FloatTitle = { bg = "NONE" },
          TabLineFill = { bg = "NONE" },
          StatusLineNC = { bg = "NONE" },
          StatusLineTermNC = { bg = "NONE" },
          LualineNormal = { bg = "NONE" },
          TabLine = { bg = "NONE" },
        },
      })
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        variant = "auto",
        transparent = false,
        italic_comments = true,
        hide_fillchars = true,
        saturation = 0.7,

        terminal_colors = false,
        cache = true,
        borderless_pickers = true,
        overrides = function(c)
          return {
            CursorLine = { bg = c.bg },
            CursorLineNr = { fg = c.magenta },
          }
        end,
      })
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  {
    "Skardyy/makurai-nvim",
    config = function()
      require("makurai").setup({
        transparent = false,
        bordered = true,
        increase_contrast = false,
      })
    end,
  },
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("black-metal").setup({
        -- transparent = true,
      })
      -- require("black-metal").load()
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#111111" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#222222" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#111111", bg = "NONE" })
      vim.api.nvim_set_hl(0, "QuickFixLine", { bg = "NONE", fg = "#e78a43" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oldworld",
    },
  },
}
