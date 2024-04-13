-- https://github.com/catppuccin/nvim/discussions/323
-- lazy = false 可以编辑器中 <leader>uC 快速切换
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- catppuccin
  -- 社区配置分享：https://github.com/catppuccin/nvim/discussions/323?sort=new
  {
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
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
					rosewater = "#efc9c2",
					flamingo = "#ebb2b2",
					pink = "#f2a7de",
					mauve = "#b889f4",
					red = "#ea7183",
					maroon = "#ea838c",
					peach = "#f39967",
					yellow = "#eaca89",
					green = "#96d382",
					teal = "#78cec1",
					sky = "#91d7e3",
					sapphire = "#68bae0",
					blue = "#739df2",
					lavender = "#a0a8f6",
					text = "#b5c1f1",
					subtext1 = "#a6b0d8",
					subtext0 = "#959ec2",
					overlay2 = "#848cad",
					overlay1 = "#717997",
					overlay0 = "#63677f",
					surface2 = "#505469",
					surface1 = "#3e4255",
					surface0 = "#2c2f40",
					-- base = "#1a1c2a",
					-- mantle = "#141620",
					-- crust = "#0e0f16",
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
			integrations = {
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				dropbar = {
					enabled = true,
					color_mode = true,
				},
			},
		},
	},
  -- solarized
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
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
  },
	{
		'projekt0n/github-nvim-theme',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('github-theme').setup({
				-- ...
			})
			vim.cmd('colorscheme github_dark')
		end,
	},
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "solarized-osaka",
      -- colorscheme = "catppuccin",
      -- colorscheme = "gruvbox",
      -- colorscheme = "nightfly",
      colorscheme = "github_dark_default",
    },
  },
}
