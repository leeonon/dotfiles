-- https://meatfighter.com/ascii-silhouettify/color-gallery.html
return {
  -- 窗口设置
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>;m", "<cmd>MaximizerToggle<CR>", desc = "最大化/最小化分割窗口" },
    },
  },
  -- LSP Hover Doc 边框设置
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
      -- 禁用显示“无可用消息”提示
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,
  },
  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    opts = {
      -- options = {
      --   buffer_close_icon = "",
      --   numbers = "ordinal",
      --   mode = "tabs",
      --   show_buffer_close_icons = false,
      --   show_close_icon = false,
      -- },
    },
  },
  -- 有趣的小插件，可以用作屏幕保护程序和仪表板。
  -- {
  --   "folke/drop.nvim",
  --   opts = {
  --     -- ...
  --   },
  -- },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- 展示尾随空格
  {
    "johnfrankmorgan/whitespace.nvim",
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      -- 宜忌

      -- local cmd = "node -e \"console.log(require('${HOME}/.config/nvim/scripts/yiji.js').getTodayYiJi())\""
      -- local handle = io.popen(cmd)
      -- local result = handle:read("*a")
      --
      -- handle:close()

      -- vim.notify(tostring(result), vim.log.levels.INFO)

      -- local yi = string.match(result, "yi: '(.*)',")
      -- if yi then
      --   yi = "宜: " .. yi
      -- else
      --   yi = "👑"
      -- end
      -- 宜忌
      local opts = {
        theme = "hyper",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          packages = { enable = true },
          week_header = {
            enable = true,
            -- concat = yi,
          },
          shortcut = {
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
            { action = "Lazy", group = "@property", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "LazyExtras", group = "DiagnosticHint", desc = " Lazy Extras", icon = " ", key = "x" },
            { action = "Telescope live_grep", group = "Number", desc = " Find Text", icon = " ", key = "g" },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
