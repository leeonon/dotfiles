local link_char = "  "
return {
  {
    -- https://github.com/iamcco/markdown-preview.nvim/issues/695
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      local g = vim.g
      g.mkdp_auto_start = 0
      g.mkdp_auto_close = 1
      g.mkdp_page_title = "${name}.md"
      g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        disable_filename = 1,
      }
      g.mkdp_theme = "dark"
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- preset = "lazy", -- none | obsidian | lazy
      code = {
        sign = false,
        border = "thin",
        position = "right",
        width = "block",
        above = "▁",
        below = "▔",
        language_left = "█",
        language_right = "█",
        language_border = "▁",
        language_icon = true,
        left_pad = 1,
        right_pad = 1,
      },
      heading = {
        width = "block",
        backgrounds = {
          "MiniStatusLineModeNormal",
          "MiniStatusLineModeInsert",
          "MiniStatusLineModeReplace",
          "MiniStatusLineModeVisual",
          "MiniStatusLineModeCommand",
          "MiniStatusLineModeOther",
        },
        sign = false,
        left_pad = 1,
        right_pad = 0,
        position = "right",
        icons = {
          "",
          "",
          "",
          "",
          "",
          "",
        },
      },
    },
    link = {
      image = "  ",
      email = "󰇮  ",
      hyperlink = link_char,
      custom = {
        web = { pattern = "^http", icon = link_char },
        sweb = { pattern = "^https", icon = link_char },
        linkedin = { pattern = "linkedin%.com", icon = "  " },
        youtube = { pattern = "youtube%.com", icon = "  " },
        github = { pattern = "github%.com", icon = "  " },
        stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌  " },
        discord = { pattern = "discord%.com", icon = "  " },
        reddit = { pattern = "reddit%.com", icon = "  " },
        acm = { pattern = "dl.acm%.org", icon = "  " },
        arxiv = { pattern = "arxiv%.org", icon = "  " },
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>um")
    end,
  },
}
