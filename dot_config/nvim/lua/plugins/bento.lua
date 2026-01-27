return {
  "serhez/bento.nvim",
  enabled = true,
  opts = {},
  config = function(_)
    require("bento").setup({
      main_keymap = ";", -- Main toggle/expand key
      lock_char = "🔒", -- Character shown before locked buffer names
      ui = {
        mode = "floating", -- "floating" | "tabline"
        floating = {
          position = "middle-right", -- See position options below
          offset_x = 0, -- Horizontal offset from position
          offset_y = 0, -- Vertical offset from position
          dash_char = "─", -- Character for collapsed dashes
          label_padding = 1, -- Padding around labels
          minimal_menu = "dashed", -- nil | "dashed" | "filename" | "full"
          max_rendered_buffers = nil, -- nil (no limit) or number for pagination
        },
        tabline = {
          left_page_symbol = "❮", -- Symbol shown when previous buffers exist
          right_page_symbol = "❯", -- Symbol shown when more buffers exist
          separator_symbol = "│", -- Separator between buffer components
        },
      },

      actions = {
        git_stage = {
          key = "g",
          hl = "DiffAdd", -- Optional: custom label color
          action = function(buf_id, buf_name)
            vim.cmd("!git add " .. vim.fn.shellescape(buf_name))
          end,
        },
      },
    })
  end,
}
