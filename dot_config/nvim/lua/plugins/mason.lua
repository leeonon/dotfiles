return {
    -- https://github.com/mason-org/mason-lspconfig.nvim/issues/545
    { "mason-org/mason-lspconfig.nvim" },
    {
        "mason-org/mason.nvim",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        opts = {
            automatic_installation = true,
            -- list of servers for mason to install
            ensure_installed = {
                "tsserver",
                "html",
                "cssls",
                "tailwindcss",
                "svelte",
                "lua_ls",
                "vue_ls",
                "emmet_ls",
                "prismals",
                "rust-analyzer",
                "cssls",
                "cssmodules_ls",
                "astro",
                "eslint",
                "biome",
                "stylua",
                "copilot-language-server",
            },
        },
        config = function()
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
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

            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier", -- prettier formatter
                    "prettierd",
                    "stylelint",
                    "stylua", -- lua formatter
                    "prisma-language-server",
                    "markdownlint",
                    "biome",
                },
            })
        end,
    },
}
