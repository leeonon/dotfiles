local function find_tailwind_global_css()
    local target = "@import 'tailwindcss';"

    -- Find project root using `.git`
    local buf = vim.api.nvim_get_current_buf()
    local root = vim.fs.root(buf, function(name)
        return name == ".git"
    end)

    if not root then
        return nil -- no project root found
    end

    -- Find stylesheet files in the project root (recursively)
    local files = vim.fs.find(function(name)
        return name:match("%.css$") or name:match("%.scss$") or name:match("%.pcss$")
    end, {
        path = root,
        type = "file",
        limit = math.huge, -- search full tree
    })

    for _, path in ipairs(files) do
        local f = io.open(path, "r")
        if f then
            local content = f:read("*a")
            f:close()

            if content:find(target, 1, true) then
                return path -- return first match
            end
        end
    end

    return nil
end

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                virtual_text = false,
            },
            inlay_hints = {
                enabled = false,
                -- exclude = { "vue", "typescript", "javascript" }, -- filetypes for which you don't want to enable inlay hints
            },
            servers = {
                eslint = {
                    settings = {
                        format = true,
                        useFlatConfig = true,
                        workingDirectory = { mode = "auto" },
                        codeActionOnSave = { enable = true, mode = "problems" },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                tailwindcss = {
                    settings = {
                        tailwindCSS = {
                            classAttributes = { "class", "className", "ngClass" },
                            experimental = {
                                configFile = find_tailwind_global_css(), -- 确保这个函数已定义
                                classRegex = {
                                    "tw`([^`]*)",
                                    "tw='([^']*)",
                                    "tw={`([^`}]*)",
                                    "tw\\.\\w+`([^`]*)",
                                    "tw\\(.*?\\)`([^`]*)",
                                    "styled\\(.*?, '([^']*)'\\)",
                                    { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                                    { "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                                    { "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
                                    { "{([\\s\\S]*)}", ":\\s*['\"`]([^'\"`]*)['\"`]" },
                                },
                            },
                        },
                    },
                },
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
                -- https://github.com/mrcjkb/rustaceanvim/blob/master/doc/mason.txt
                rust_analyzer = function()
                    return true
                end,
                lua_ls = function()
                    require("lspconfig.ui.windows").default_options.border = "single"
                end,

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
                --             -- Only run if eslint is actually attached to this buffer
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
    },
    -- 展示 Lsp 加载进度UI
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
    },
}
