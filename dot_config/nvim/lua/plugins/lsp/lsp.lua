local config = {
    -- format = {
    --   insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true,
    --   insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
    --   semicolons = "remove",
    -- },
    -- implementationsCodeLens = {
    --   enabled = true,
    --   showOnInterfaceMethods = true,
    -- },
    inlayHints = {
        enumMemberValues = { enabled = false },
        functionLikeReturnTypes = { enabled = false },
        parameterNames = { enabled = "none" },
        parameterTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = false },
        variableTypes = { enabled = false },
    },
    -- referencesCodeLens = {
    --   enabled = true,
    --   showOnAllFunctions = true,
    -- },
}

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
        config = function(_)
            vim.diagnostic.virtual_text = false

            local eslint_base_on_attach = vim.lsp.config.eslint.on_attach

            vim.lsp.enable("eslint")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("volar")
            vim.lsp.enable("cssls")
            vim.lsp.enable("svelte")
            vim.lsp.enable("cssmodules_ls")
            vim.lsp.enable("vtsls")

            vim.lsp.config("eslint", {
                settings = {
                    format = { enable = true },
                    useFlatConfig = true,
                    workingDirectory = { mode = "auto" },
                    codeActionOnSave = { enable = true, mode = "problems" },
                },
                on_attach = function(client, bufnr)
                    if eslint_base_on_attach ~= nil then
                        eslint_base_on_attach(client, bufnr)
                    end

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "LspEslintFixAll",
                    })
                end,
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            vim.lsp.config("tailwindcss", {
                settings = {
                    tailwindCSS = {
                        classAttributes = { "class", "className", "ngClass" },
                        experimental = {
                            -- configFile = "/Users/ly/code/github/molink/app/src/lib/styles/tailwind.css",
                            -- TODO: 在 Tailwind v4 中寻找配置文件的解决方案，关注 PR 状态: https://github.com/neovim/nvim-lspconfig/pull/4222/files
                            configFile = find_tailwind_global_css(),
                            classRegex = {
                                "tw`([^`]*)", -- tw`...`
                                "tw='([^']*)", -- <div tw="..." />
                                "tw={`([^`}]*)", -- <div tw={"..."} />
                                "tw\\.\\w+`([^`]*)", -- tw.xxx`...`
                                "tw\\(.*?\\)`([^`]*)", -- tw(component)`...`
                                "styled\\(.*?, '([^']*)'\\)",
                                { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                                { "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                                { "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
                                { "{([\\s\\S]*)}", ":\\s*['\"`]([^'\"`]*)['\"`]" },
                            },
                        },
                    },
                },
            })

            vim.lsp.config("volar", {
                settings = {
                    css = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    scss = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                },
            })

            vim.lsp.config("cssls", {
                settings = {
                    css = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    scss = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                },
            })

            vim.lsp.config("vtsls", {
                settings = {
                    javascript = config,
                    typescript = config,
                },
            })

            vim.lsp.config("svelte", {
                on_attach = function(client)
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        pattern = { "*.js", "*.ts" },
                        callback = function(ctx)
                            -- Here use ctx.match instead of ctx.file
                            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                        end,
                    })
                end,
            })

            vim.lsp.config("cssmodules_ls", {
                enabled = false,
            })

            vim.lsp.config("vtsls", {
                -- 使用 typescript-tools.nvim
                -- Vue_ls 需要这个？
                enabled = false,
                settings = {
                    javascript = config,
                    typescript = config,
                },
            })
        end,
    },
    -- 展示 Lsp 加载进度UI
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
    },
}
