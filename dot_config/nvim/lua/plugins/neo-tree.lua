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
        winbar = true,
        statusline = true,
      },
      buffers = { follow_current_file = { enabled = true } },
      window = {
        position = "float",
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
        indent = {
          -- enabled = false,
          indent_size = 3,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          -- with_markers = true,
          -- indent_marker = "",
          -- last_indent_marker = "└",
          -- highlight = "NeoTreeIndentMarker",
          -- -- expander config, needed for nesting files
          -- with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          -- expander_collapsed = "",
          -- expander_expanded = "",
          -- expander_highlight = "NeoTreeExpander",
        },
      },
      filesystem = {
        window = {
          mappings = {
            -- 使用 o 快捷键用本机系统查看器打开文件或者目录
            ["o"] = "system_open",
          },
        },
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
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- macOs: open file in default application in the background.
          vim.fn.jobstart({ "open", path }, { detach = true })
          -- Linux: open file in default application
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })

          -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
          local p
          local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
          if lastSlashIndex then
            p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
          else
            p = path -- If no slash found, return original path
          end
          vim.cmd("silent !start explorer " .. p)
        end,
      },
    })
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal float<CR>", {})
  end,
}
