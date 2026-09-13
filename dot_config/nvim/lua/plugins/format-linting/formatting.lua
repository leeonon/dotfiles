-- conform：按项目配置选择 oxfmt / biome / prettier
local toolchain = require("config.toolchain")

return {
    "stevearc/conform.nvim",
    opts = {
        formatters = {
            timeout_ms = 3000,
            biome = {
                require_cwd = true,
            },
        },
        formatters_by_ft = {
            javascript = toolchain.formatter,
            typescript = toolchain.formatter,
            javascriptreact = toolchain.formatter,
            vue = toolchain.formatter,
            typescriptreact = toolchain.formatter,
            svelte = toolchain.formatter,
            astro = toolchain.formatter,
            css = toolchain.formatter,
            less = { "stylelint" },
            html = toolchain.formatter,
            json = function(bufnr)
                return toolchain.formatter(bufnr, { "prettierd" })
            end,
            jsonc = function(bufnr)
                return toolchain.formatter(bufnr, { "prettierd" })
            end,
            yaml = toolchain.formatter,
            markdown = toolchain.formatter,
            graphql = toolchain.formatter,
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt" },
        },
    },
}
