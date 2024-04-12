return {
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
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
        ███████╗██╗  ██╗██████╗ ███████╗██╗  ██╗██████╗
        ██╔════╝██║ ██╔╝██╔══██╗██╔════╝██║ ██╔╝██╔══██╗
        ███████╗█████╔╝ ██████╔╝███████╗█████╔╝ ██████╔╝
        ╚════██║██╔═██╗ ██╔══██╗╚════██║██╔═██╗ ██╔══██╗
        ███████║██║  ██╗██║  ██║███████║██║  ██╗██║  ██║
        ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
