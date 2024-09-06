return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✅",
          package_pending = "➡️",
          package_uninstalled = "❌",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "emmet_ls",
        "prismals",
        "rust-analyzer",
        "cssls",
        "cssmodules_ls",
        "astro",
        -- eslint 无法自动Fix问题
        -- https://github.com/neovim/nvim-lspconfig/issues/3146
        -- https://github.com/hrsh7th/vscode-langservers-extracted/commit/859ca87fd778a862ee2c9f4c03017775208d033a#commitcomment-141868488
        -- https://github.com/hrsh7th/vscode-langservers-extracted/commit/859ca87fd778a862ee2c9f4c03017775208d033a#commitcomment-142170603
        "eslint",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylelint",
        "stylua", -- lua formatter
        "prisma-language-server",
        "markdownlint",
      },
    })
  end,
}
