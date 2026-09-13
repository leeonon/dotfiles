-- TS/Vue 前端生态 LSP servers 及 setup hooks
return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            eslint = {
                settings = {
                    format = true,
                    useFlatConfig = true,
                    workingDirectory = { mode = "auto" },
                    codeActionOnSave = { enable = true, mode = "problems" },
                },
            },
            -- 仅在项目存在 biome.json(c) 时 attach（lspconfig 自带探测）
            biome = {},
            volar = {
                settings = {
                    css = { validate = true, lint = { unknownAtRules = "ignore" } },
                    scss = { validate = true, lint = { unknownAtRules = "ignore" } },
                },
            },
            cssls = {
                settings = {
                    css = { validate = true, lint = { unknownAtRules = "ignore" } },
                    scss = { validate = true, lint = { unknownAtRules = "ignore" } },
                },
            },
            cssmodules_ls = { enabled = false },
            vtsls = {},
            tsgo = {
                -- 新版 nvim-lspconfig 将 tsgo 并入 tsc 且优先使用本地 node_modules/.bin/tsc，
                -- 但普通 tsc 不支持 --lsp 会直接 exit 1，这里强制只用 tsgo
                cmd = function(dispatchers, config)
                    local cmd = "tsgo"
                    if config and config.root_dir then
                        local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", "tsgo")
                        if vim.fn.executable(local_cmd) == 1 then
                            cmd = local_cmd
                        end
                    end
                    return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
                end,
                settings = {
                    typescript = {
                        inlayHints = {
                            enumMemberValues = { enabled = false },
                            functionLikeReturnTypes = { enabled = false },
                            parameterNames = {
                                enabled = "literals",
                                suppressWhenArgumentMatchesName = false,
                            },
                            parameterTypes = { enabled = false },
                            propertyDeclarationTypes = { enabled = false },
                            variableTypes = { enabled = false },
                        },
                    },
                },
            },
        },
        setup = {
            -- eslint = function()
            --     local formatter = LazyVim.lsp.formatter({
            --         name = "eslint: lsp",
            --         primary = false,
            --         priority = 200,
            --         filter = "eslint",
            --
            --         -- 这里目前使用 Code Action 处理, 而不是 format
            --         -- CodeAction 修复ESLint 可自动修复的问题
            --         -- Fomat 只处理代码风格，格式化处理
            --         -- format = function(_)
            --         --     vim.lsp.buf.code_action({
            --         --         apply = true,
            --         --         context = {
            --         --             only = { "source.fixAll.eslint" },
            --         --             diagnostics = {},
            --         --         },
            --         --     })
            --         -- end,
            --         -- sources = function(buf)
            --         --     local clients = vim.lsp.get_clients({ name = "eslint", bufnr = buf })
            --         --     return vim.tbl_map(function(c)
            --         --         return c.name
            --         --     end, clients)
            --         -- end,
            --
            --         format = function(buf)
            --             -- Only run if eslint is actually attached to the buffer
            --             local clients = vim.lsp.get_clients({ bufnr = buf, name = "eslint" })
            --             if #clients == 0 then
            --                 return
            --             end
            --             -- TODO: 不手动设置  LspEslintFixAll 时自动保存格式化失效，Lazyvim 并没有设置, 找找原因
            --             -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/linting/eslint.lua
            --
            --             Snacks.util.lsp.on({ "eslint" }, function()
            --                 if vim.fn.exists(":LspEslintFixAll") == 2 then
            --                     vim.cmd("LspEslintFixAll")
            --                 end
            --             end)
            --         end,
            --     })
            --     LazyVim.format.register(formatter)
            -- end,
            biome = function(_, opts)
                opts.on_attach = function(client, bufnr)
                    local group = vim.api.nvim_create_augroup("LspBiomeFormat_" .. bufnr, { clear = true })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = group,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
                return false
            end,

            svelte = function(_, opts)
                opts.on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        pattern = { "*.js", "*.ts" },
                        callback = function(ctx)
                            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                        end,
                    })
                end
                return false
            end,
        },
    },
}
