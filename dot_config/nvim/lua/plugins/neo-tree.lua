return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      sources = { "filesystem", "git_status", "buffers" },
      source_selector = {
        -- 是否展示 winbar
        winbar = true,
        statusline = false,
      },
      buffers = { follow_current_file = { enabled = true } },
      window = {
        position = "left",
        mappings = {
          -- 打开文件而不失去侧边栏焦点
          ["<tab>"] = function(state)
            local node = state.tree:get_node()
            if require("neo-tree.utils").is_expandable(node) then
              state.commands["toggle_node"](state)
            else
              state.commands["open"](state)
              vim.cmd("Neotree reveal")
            end
          end,
        },
      },
      default_component_configs = {
        -- indent = {
        --   indent_size = 2,
        --   padding = 1, -- extra padding on left hand side
        --   -- indent guides
        --   with_markers = true,
        --   indent_marker = "",
        --   last_indent_marker = "└",
        --   highlight = "NeoTreeIndentMarker",
        --   -- expander config, needed for nesting files
        --   with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        --   expander_collapsed = "",
        --   expander_expanded = "",
        --   expander_highlight = "NeoTreeExpander",
        -- },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- add extension names you want to explicitly exclude
            ".git",
            "node_modules",
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
      follow_current_file = {
        enabled = true, -- 这将在每次激活缓冲区时查找并聚焦该文件
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
    })
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
  end,
}
