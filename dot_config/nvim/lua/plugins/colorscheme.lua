-- https://github.com/catppuccin/nvim/discussions/323
-- lazy = false 可以编辑器中 <leader>uC 快速切换
return {
  -- add gruvbox
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      transparent_background = true,
      gamma = 1.00,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        identifiers = { italic = true },
        functions = {},
        variables = {},
      },
      custom_highlights = {} or function(highlights, palette)
        return {}
      end, -- extend highlights
      custom_palette = {} or function(palette)
        return {}
      end, -- extend palette
      terminal_colors = true, -- enable terminal colors
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
        transparent = true, -- do not set background color
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
        transparent_mode = true,
      })
    end,
  },
  {
    "Everblush/nvim",
    name = "everblush",
    config = function()
      require("everblush").setup({
        transparent_background = true,
      })
    end,
  },
  {
    "oxfist/night-owl.nvim",
    -- config = function()
    --   require("night-owl").setup({
    --     bold = true,
    --     italics = true,
    --     underline = true,
    --     undercurl = true,
    --     transparent_background = true,
    --   })
    -- end,
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
  {
    "Shatur/neovim-ayu",
    config = function()
      require("ayu").setup({
        overrides = {
          Normal = { bg = "None" },
          ColorColumn = { bg = "None" },
          SignColumn = { bg = "None" },
          Folded = { bg = "None" },
          FoldColumn = { bg = "None" },
          CursorLine = { bg = "None" },
          CursorColumn = { bg = "None" },
          WhichKeyFloat = { bg = "None" },
          VertSplit = { bg = "None" },
        },
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
  { "nuvic/flexoki-nvim", as = "flexoki" },
  {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function() end,
  },
  {
    "comfysage/cuddlefish.nvim",
    config = function()
      require("cuddlefish").setup({
        theme = {
          accent = "pink",
        },
        editor = {
          transparent_background = true,
        },
        style = {
          tabline = { "reverse" },
          search = { "italic", "reverse" },
          incsearch = { "italic", "reverse" },
          types = { "italic" },
          keyword = { "italic" },
          comment = { "italic" },
        },
        overrides = function(colors)
          return {}
        end,
      })
    end,
  },
  {
    "comfysage/evergarden",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      -- theme = {
      --   variant = "fall", -- 'winter'|'fall'|'spring'
      --   accent = "green",
      -- },
      editor = {
        transparent_background = true,
        -- sign = { color = "none" },
        -- float = {
        --   color = "mantle",
        --   invert_border = false,
        -- },
        -- completion = {
        --   color = "surface0",
        -- },
      },
      -- style = {
      --   tabline = { "reverse" },
      --   search = { "italic", "reverse" },
      --   incsearch = { "italic", "reverse" },
      --   types = { "italic" },
      --   keyword = { "italic" },
      --   comment = { "italic" },
      -- },
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
      vim.g.gruvbox_material_transparent_background = 1
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

        integrations = {
          navic = true,
          alpha = false,
          rainbow_delimiters = false,
        },
        highlight_overrides = {
          Normal = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          CursorLine = { bg = "#222128" },
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
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "ptdewey/monalisa-nvim",
    priority = 1000,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({
        -- This callback can be used to override the colors used in the base palette.
        on_palette = function(palette) end,
        -- This callback can be used to override the colors used in the extended palette.
        after_palette = function(palette) end,
        -- This callback can be used to override highlights before they are applied.
        on_highlight = function(highlights, palette) end,
        -- Enable bold keywords.
        bold_keywords = false,
        -- Enable italic comments.
        italic_comments = true,
        -- Enable editor background transparency.
        transparent = {
          -- Enable transparent background.
          bg = true,
          -- Enable transparent background for floating windows.
          float = true,
        },
        -- Enable brighter float border.
        bright_border = false,
        -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        reduced_blue = true,
        -- Swap the dark background with the normal one.
        swap_backgrounds = false,
        -- Cursorline options.  Also includes visual/selection.
        cursorline = {
          -- Bold font in cursorline.
          bold = false,
          -- Bold cursorline number.
          bold_number = true,
          -- Available styles: 'dark', 'light'.
          theme = "dark",
          -- Blending the cursorline bg with the buffer bg.
          blend = 0.85,
        },
        noice = {
          -- Available styles: `classic`, `flat`.
          style = "classic",
        },
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = "flat",
        },
        leap = {
          -- Dims the backdrop when using leap.
          dim_backdrop = false,
        },
        ts_context = {
          -- Enables dark background for treesitter-context window
          dark_background = true,
        },
      })
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyTransparent = true
      vim.g.moonflyItalics = true
      vim.g.moonflyNormalFloat = true
      vim.o.winborder = "single"
    end,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nightflyItalics = true
      vim.g.nightflyNormalFloat = true
      vim.g.nightflyTerminalColors = true
      vim.g.nightflyTransparent = true
      vim.g.nightflyUnderlineMatchParen = true
      -- Lua initialization file
      vim.g.nightflyVirtualTextColor = true
      -- Lua initialization file
      vim.g.nightflyWinSeparator = 0
      -- vim.o.winborder = "single"
    end,
  },
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    name = "black-metal",
    config = function()
      require("black-metal").setup({
        theme = "bathory",
        variant = "dark",
      })
      -- require("black-metal").load()
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "moonfly",
      -- colorscheme = "nightfly",
      -- colorscheme = "cyberdream",
      -- colorscheme = "everblush",
      -- colorscheme = "oldworld",
      -- colorscheme = "darkbox",
      -- colorscheme = "jellybeans",
      -- colorscheme = "gruvbox-material",
      -- colorscheme = "oxocarbon",
      -- colorscheme = "monalisa",
      -- colorscheme = "catppuccin",
      -- colorscheme = "kanagawa",
      -- colorscheme = "gruvbox",
      -- colorscheme = "everforest",
      -- colorscheme = "everforest",
      -- colorscheme = "tokyodark",
      colorscheme = "kanagawa",
      -- colorscheme = "ayu",
      -- colorscheme = "rose-pine",
      -- colorscheme = "tokyonight",
      -- colorscheme = "four-symbols",
      -- colorscheme = "evergarden",
      -- colorscheme = "cuddlefish",
      -- colorscheme = "gruvboxed",
      -- colorscheme = "nord",
      -- colorscheme = "miasma",
      -- colorscheme = "flow",
      -- colorscheme = "moonfly",
      -- colorscheme = "shadow",
      -- colorscheme = "onenord",
      -- colorscheme = "night-owl",
    },
  },
}
