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
			custom_highlights = function(highlights, palette)
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
			custom_palette = function(palette)
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
				variant = "oled", -- default, oled, cooler
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
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					FloatTitle = { bg = "NONE" },
					TabLineFill = { bg = "NONE" },
					StatusLineNC = { bg = "NONE" },
					StatusLineTermNC = { bg = "NONE" },
					TabLine = { bg = "NONE" },
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
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				variant = "auto",
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,
				saturation = 0.8,

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
		"bettervim/yugen.nvim",
		config = function()
			-- vim.cmd.colorscheme("yugen")
		end,
	},
	{
		"0xstepit/flow.nvim",
		lazy = false,
		priority = 1000,
		tag = "v2.0.1",
		opts = {
			theme = {
				style = "dark", --  "dark" | "light"
				contrast = "default", -- "default" | "high"
				transparent = true,
			},
			colors = {
				mode = "default", -- "default" | "dark" | "light"
				fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
				custom = {
					saturation = "", -- "" | string representing an integer between 0 and 100
					light = "", -- "" | string representing an integer between 0 and 100
				},
			},
			ui = {
				borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
				aggressive_spell = false, -- true | false
			},
		},
		config = function(_, opts)
			require("flow").setup(opts)
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			-- colorscheme = "poimandres",
			-- colorscheme = "moonfly",
			-- colorscheme = "yugen",
			-- colorscheme = "nightfly",
			colorscheme = "cyberdream",
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
			-- colorscheme = "darkmatter",
			-- colorscheme = "kanagawa",
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
