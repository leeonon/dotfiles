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
                vtsls = { enabled = false }, -- 如果要用 typescript-tools.nvim
            },
            setup = {
                eslint = function()
                    local formatter = LazyVim.lsp.formatter({
                        name = "eslint: lsp",
                        primary = false,
                        priority = 200,
                        filter = "eslint",
                        -- TODO: 不手动设置  LspEslintFixAll 时自动保存格式化失效，Lazyvim 并没有设置, 找找原因
                        -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/linting/eslint.lua
                        format = function()
                            Snacks.util.lsp.on({ "eslint" }, function()
                                vim.cmd("LspEslintFixAll")
                            end)
                        end,
                    })

                    -- register the formatter with LazyVim
                    LazyVim.format.register(formatter)
                end,

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
