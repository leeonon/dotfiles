-- 配置技巧 https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    { "<leader>e", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
    { "<leader><tab>e", ":Neotree toggle left<CR>", silent = true, desc = "Left File Explorer" },
  },
  opts = {
    sources = { "filesystem", "git_status", "buffers" },
    source_selector = {
      -- 是否展示 winbar
      winbar = true,
      statusline = false,
    },
    window = {
      -- position = "left",
      position = "float",
      mappings = {
        ["o"] = "open",
        ["e"] = function()
          vim.api.nvim_exec("Neotree focus filesystem left", true)
        end,
        ["b"] = function()
          vim.api.nvim_exec("Neotree focus buffers left", true)
        end,
        ["g"] = function()
          vim.api.nvim_exec("Neotree focus git_status left", true)
        end,
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
      width = 35,
    },
    close_if_last_window = true, --关闭最后一个窗口时关闭 neotree
    popup_border_style = "rounded", --弹窗边框样式
    enable_git_status = true, --启用git状态
    enable_modified_markers = true, --启用修改标记
    enable_diagnostics = true, --启用诊断
    sort_case_insensitive = true, --忽略大小写排序
    default_component_configs = {
      indent = {
        with_markers = true,
        with_expanders = true,
      },
      modified = {
        symbol = " ",
        highlight = "NeoTreeModified",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        folder_empty_open = "",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "",
          deleted = "",
          modified = "",
          renamed = "",
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    event_handlers = {
      -- 打开文件时自动关闭 neotree
      {
        event = "file_opened",
        handler = function(file_path)
          -- auto close
          -- vimc.cmd("Neotree close")
          -- OR
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
    setup = function()
      vim.api.nvim_exec("Neotree focus filesystem left", true)
    end,
  },
}
