local inputs = require("neo-tree.ui.inputs")

-- Trash the target
local function trash(state)
  local node = state.tree:get_node()
  if node.type == "message" then
    return
  end
  local _, name = require("neo-tree.utils").split_path(node.path)
  local msg = string.format("Are you sure you want to trash '%s'?", name)
  inputs.confirm(msg, function(confirmed)
    if not confirmed then
      return
    end
    vim.api.nvim_command("silent !trash -F " .. node.path)
    require("neo-tree.sources.manager").refresh(state)
  end)
end

-- Trash the selections (visual mode)
local function trash_visual(state, selected_nodes)
  local paths_to_trash = {}
  for _, node in ipairs(selected_nodes) do
    if node.type ~= "message" then
      table.insert(paths_to_trash, node.path)
    end
  end
  local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
  inputs.confirm(msg, function(confirmed)
    if not confirmed then
      return
    end
    for _, path in ipairs(paths_to_trash) do
      vim.api.nvim_command("silent !trash -F " .. path)
    end
    require("neo-tree.sources.manager").refresh(state)
  end)
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "mrbjarksen/neo-tree-diagnostics.nvim",
  },
  config = function()
    require("neo-tree").setup({
      popup_border_style = "rounded",
      close_if_last_window = true,
      sources = { "filesystem", "git_status", "buffers", "diagnostics" },
      source_selector = {
        winbar = true,
        statusline = true,
        show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
        -- of the top visible node when scrolled down.
        sources = { -- falls back to source_name if nil
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "buffers", display_name = " 󰈙 Buffers " },
          { source = "git_status", display_name = " 󰊢 Git " },
          { source = "document_symbols", display_name = " 󰊕 Symbols " },
          { source = "diagnostics", display_name = " 󰒘 Diagnostics " },
        },
        content_layout = "center", -- only with `tabs_layout` = "equal", "focus"
        tabs_layout = "equal", -- start, end, center, equal, focus
        truncation_character = "…", -- character to use when truncating the tab label
        padding = 0, -- can be int or table
        separator = { left = "▏", right = "▕" },
        show_separator_on_edge = false,
      },
      buffers = { follow_current_file = { enabled = true } },
      window = {
        position = "float", -- left, right, top, bottom, float, current
        mappings = {
          ["T"] = "trash", -- 将文件或目录移动到回收站
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
          indent_size = 2,
          padding = 0, -- extra padding on left hand side
          indent_marker = "|", -- "│",
          last_indent_marker = "╰",
        },
      },
      filesystem = {
        window = {
          mappings = {
            -- 使用 o 快捷键用本机系统查看器打开文件或者目录
            ["o"] = "system_open",
            -- 将文件/文件夹添加到 avante 文件选择器
            ["va"] = "avante_add_files",
          },
        },
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            "node_modules",
            ".DS_Store",
          },
          never_show = {},
        },
      },
      follow_current_file = {
        enabled = true, -- 这将在每次激活缓冲区时查找并聚焦该文件
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      commands = {
        trash = trash,
        trash_visual = trash_visual,
        avante_add_files = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local relative_path = require("avante.utils").relative_path(filepath)

          local sidebar = require("avante").get()

          local open = sidebar:is_open()
          -- 确保 avante 侧边栏已打开
          if not open then
            require("avante.api").ask()
            sidebar = require("avante").get()
          end

          sidebar.file_selector:add_selected_file(relative_path)

          -- 删除 neo tree 缓冲区
          if not open then
            sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
          end
        end,
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
    vim.keymap.set("n", "<C-m>", ":Neotree filesystem reveal float<CR>", {})
    -- vim.keymap.set("n", "<C-i>", ":Neotree reveal<cr>", {
    --   desc = "Toggle Neo-tree",
    -- })
  end,
}
