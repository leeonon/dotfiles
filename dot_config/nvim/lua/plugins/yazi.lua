---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>-",
      function()
        require("yazi").yazi()
      end,
      desc = "Open the file manager",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      function()
        -- NOTE: requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        require("yazi").toggle()
      end,
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,

    -- enable these if you are using the latest version of yazi
    -- use_ya_for_events_reading = true,
    -- use_yazi_client_id_flag = true,
  },
  init = function()
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1
  end,
}
