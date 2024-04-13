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
  opts = {
    sources = { "filesystem", "git_status", "buffers" },
    source_selector = {
      -- 是否展示 winbar
      winbar = true,
    },
    window = {
      position = "left",
      mappings = {
        ['o'] = "open",
        ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
        ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
        ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
        -- 打开文件而不失去侧边栏焦点
        ['<tab>'] = function (state)
          local node = state.tree:get_node()
          if require("neo-tree.utils").is_expandable(node) then
            state.commands["toggle_node"](state)
          else
            state.commands['open'](state)
            vim.cmd('Neotree reveal')
          end
        end,
      },
      width = 35,
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
        end
      },
    },
    setup = function()
      vim.api.nvim_exec('Neotree focus filesystem left', true)
    end,
  }
}