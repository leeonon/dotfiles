-- https://github.com/catppuccin/nvim/discussions/323
-- lazy = false 可以编辑器中 <leader>uC 快速切换

return {
    -- add gruvbox
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
        },
    },
    {
        "tiagovla/tokyodark.nvim",
        opts = {
            transparent_background = true,
            gamma = 1.00,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                identifiers = { italic = false },
                functions = {},
                variables = {},
            },
            custom_highlights = function()
                return {
                    StatusLine = { bg = "NONE" },
                }
            end,
            on_colors = function(colors)
                colors.hint = colors.orange
                colors.error = "#ff0000"
            end,
            custom_palette = function()
                return {}
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
    -- 在线生成主题配置: https://catbbrew.com/design
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "macchiato",
            -- background = {
            --   light = "latte",
            --   dark = "mocha",
            -- },
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
            highlight_overrides = {
                all = function(colors)
                    return {
                        CurSearch = { bg = colors.sky },
                        IncSearch = { bg = colors.sky },
                        CursorLineNr = { fg = colors.blue, style = { "bold" } },
                        DashboardFooter = { fg = colors.overlay0 },
                        WinSeparator = { fg = colors.overlay0, style = { "bold" } },
                        ["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
                        ["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
                        Headline = { style = { "bold" } },
                        Headline1 = { fg = colors.blue, style = { "bold" } },
                        Headline2 = { fg = colors.pink, style = { "bold" } },
                        Headline3 = { fg = colors.lavender, style = { "bold" } },
                        Headline4 = { fg = colors.green, style = { "bold" } },
                        Headline5 = { fg = colors.peach, style = { "bold" } },
                        Headline6 = { fg = colors.flamingo, style = { "bold" } },
                        rainbow1 = { fg = colors.blue, style = { "bold" } },
                        rainbow2 = { fg = colors.pink, style = { "bold" } },
                        rainbow3 = { fg = colors.lavender, style = { "bold" } },
                        rainbow4 = { fg = colors.green, style = { "bold" } },
                        rainbow5 = { fg = colors.peach, style = { "bold" } },
                        rainbow6 = { fg = colors.flamingo, style = { "bold" } },
                    }
                end,
            },
            color_overrides = {
                mocha = {
                    base = "#000000",
                    mantle = "#000000",
                    crust = "#000000",
                },
                macchiato = {
                    rosewater = "#F5B8AB",
                    flamingo = "#F29D9D",
                    pink = "#AD6FF7",
                    mauve = "#FF8F40",
                    red = "#E66767",
                    maroon = "#EB788B",
                    peach = "#FAB770",
                    yellow = "#FACA64",
                    green = "#70CF67",
                    teal = "#4CD4BD",
                    sky = "#61BDFF",
                    sapphire = "#4BA8FA",
                    blue = "#00BFFF",
                    lavender = "#00BBCC",
                    text = "#C1C9E6",
                    subtext1 = "#A3AAC2",
                    subtext0 = "#8E94AB",
                    overlay2 = "#7D8296",
                    overlay1 = "#676B80",
                    overlay0 = "#464957",
                    surface2 = "#3A3D4A",
                    surface1 = "#2F313D",
                    surface0 = "#1D1E29",
                    base = "#0b0b12",
                    mantle = "#11111a",
                    crust = "#191926",
                },
            },
            integrations = {
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
            },
        },
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

                    -- BlinkCmpIcon
                    -- BlinkCmpKindIconField = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconProperty = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconEvent = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconText = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconEnum = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconKeyword = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconConstant = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconConstructor = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconReference = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconFunction = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconStruct = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconClass = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconModule = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconOperator = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconVariable = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconFile = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconUnit = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconSnippet = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconFolder = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconInterface = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconColor = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconTypeParameter = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconMethod = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconValue = { fg = fg_color, bg = bg_color },
                    -- BlinkCmpKindIconEnumMember = { fg = fg_color, bg = bg_color },
                },
            })
        end,
    },
    {
        "2nthony/vitesse.nvim",
        dependencies = {
            "tjdevries/colorbuddy.nvim",
        },
        config = function()
            vim.opt.winblend = 0
            vim.opt.pumblend = 0
            require("vitesse").setup({
                comment_italics = true,
                transparent_background = true,
                transparent_float_background = true, -- aka pum(popup menu) background
                reverse_visual = false,
                dim_nc = false,
                cmp_cmdline_disable_search_highlight_group = false, -- disable search highlight group for cmp item
                -- if `transparent_float_background` false, make telescope border color same as float background
                telescope_border_follow_float_background = false,
                -- similar to above, but for lspsaga
                lspsaga_border_follow_float_background = false,
                -- diagnostic virtual text background, like error lens
                diagnostic_virtual_text_background = false,

                -- override the `lua/vitesse/palette.lua`, go to file see fields
                colors = {},
                themes = {},
            })
        end,
    },
    {
        "mcauley-penney/techbase.nvim",
        opts = {
            italic_comments = true,
            transparent = false,
            plugin_support = {
                visual_whitespace = true,
                aerial = false,
                blink = true,
                edgy = false,
                gitsigns = true,
                hl_match_area = true,
                lazy = true,
                lualine = true,
                mason = true,
                mini_cursorword = true,
                nvim_cmp = false,
                vim_illuminate = true,
            },
            hl_overrides = {},
        },
        init = function()
            -- vim.cmd.colorscheme("techbase")
        end,
        priority = 1000,
    },
    {
        "bettervim/yugen.nvim",
        config = function() end,
    },
    {
        "sam4llis/nvim-tundra",
        config = function()
            require("nvim-tundra").setup({
                transparent_background = true,
                dim_inactive_windows = {
                    enabled = false,
                    color = nil,
                },
                sidebars = {
                    enabled = false,
                    color = nil,
                },
                syntax = {
                    booleans = { bold = true, italic = true },
                    comments = { bold = true, italic = true },
                    constants = { bold = true },
                    numbers = { bold = true },
                    operators = { bold = true },
                    types = { italic = true },
                },
                diagnostics = {
                    errors = {},
                    warnings = {},
                    information = {},
                    hints = {},
                },
                plugins = {
                    lsp = true,
                    semantic_tokens = true,
                    treesitter = true,
                    telescope = true,
                    nvimtree = true,
                    cmp = true,
                    context = true,
                    dbui = true,
                    gitsigns = true,
                    neogit = true,
                    textfsm = true,
                },
                overwrite = {
                    colors = {},
                    highlights = {
                        NonText = { fg = "#5c6370" },
                    },
                },
            })

            vim.g.tundra_biome = "jungle" -- 'arctic' or 'jungle'
            vim.opt.background = "dark"
        end,
    },
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_background = "hard" -- ‘hard’ | ‘medium’(默认) | ‘soft’。
            vim.g.gruvbox_material_foreground = "material" -- ‘material’(默认) | ‘mix’ | ‘original’
            vim.g.gruvbox_material_disable_italic_comment = 0 --禁用 Comment 组的斜体。
            vim.g.gruvbox_material_enable_bold = 1 -- 函数名启用粗体
            vim.g.gruvbox_material_cursor = "auto"
            vim.g.gruvbox_material_show_eob = 0 -- 控制 hl-EndOfBuffer 的可见性。
            vim.g.gruvbox_material_ui_contrast = "high"
            vim.g.gruvbox_material_float_style = "bright"
            vim.g.gruvbox_material_transparent_background = 2 -- 0: 不透明背景, 1 开启主体透明；2 扩展更多 UI（如状态栏）也透明
        end,
    },
    {
        "oskarnurm/koda.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("koda").setup({
                transparent = true,
                styles = {
                    functions = { bold = true },
                    keywords = {},
                    comments = {
                        italic = true,
                    },
                    strings = {},
                    constants = {}, -- includes numbers, booleans
                },
                colors = {
                    bg = "#101010",
                    fg = "#b0b0b0",
                    dim = "#000000",
                    line = "#272727",
                    keyword = "#777777",
                    comment = "#50585d",
                    border = "#ffffff",
                    emphasis = "#ffffff",
                    func = "#ffffff",
                    string = "#ffffff",
                    const = "#d9ba73",
                    highlight = "#458ee6",
                    info = "#8ebeec",
                    success = "#86cd82",
                    warning = "#d9ba73",
                    danger = "#ff7676",
                    green = "#14ba19",
                    orange = "#f54d27",
                    red = "#701516",
                    yellow = "#d0bf41",
                    pink = "#f2a4db",
                    cyan = "#5abfb5",
                },
                on_highlights = function(hl, c)
                    -- hl.Visual = { fg = "#fb2b2b", bg = c.dim }
                    -- hl.CursorLine = { bg = c.dim }
                    -- hl.FloatBorder = { bg = "NONE", fg = c.border }
                    hl.WinSeparator = { fg = c.line, bg = "NONE" }
                    hl.String = { fg = c.success }
                    hl.Comment = { fg = c.comment, italic = true }
                end,
            })
        end,
    },
    {
        "serhez/teide.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
        },
    },
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        config = function()
            require("ayu").setup({
                mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
                terminal = true, -- Set to `false` to let terminal manage its own colors.
                overrides = {
                    Normal = { bg = "None" },
                    NormalFloat = { bg = "none" },
                    ColorColumn = { bg = "None" },
                    SignColumn = { bg = "None" },
                    Folded = { bg = "None" },
                    FoldColumn = { bg = "None" },
                    CursorLine = { bg = "None" },
                    CursorColumn = { bg = "None" },
                    VertSplit = { bg = "None" },
                    Comment = { italic = true },
                },
            })
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            -- colorscheme = "yugen",
            -- colorscheme = "tokyodark",
            -- colorscheme = "everforest",
            -- colorscheme = "catppuccin",
            -- colorscheme = "gruvbox-material",
            -- colorscheme = "tundra",
            -- colorscheme = "techbase",
            colorscheme = "teide-darker",
            -- colorscheme = "koda",
            -- colorscheme = "ayu-dark",
        },
    },
}
