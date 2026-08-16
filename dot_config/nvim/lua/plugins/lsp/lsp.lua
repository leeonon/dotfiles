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

    -- Directories we never descend into (huge and never hold the entry css)
    local skip_dirs = {
        ["node_modules"] = true,
        [".git"] = true,
        [".next"] = true,
        [".nuxt"] = true,
        [".svelte-kit"] = true,
        [".turbo"] = true,
        [".cache"] = true,
        ["dist"] = true,
        ["build"] = true,
        ["out"] = true,
        ["target"] = true,
        ["vendor"] = true,
        [".venv"] = true,
    }

    -- Walk the tree ourselves so we can prune heavy dirs (vim.fs.find can't).
    -- Depth cap is just a safety net; the prune list is what actually matters.
    local function scan(dir, depth)
        if depth > 10 then
            return nil
        end
        for name, type in vim.fs.dir(dir) do
            local path = vim.fs.joinpath(dir, name)
            if type == "directory" then
                if not skip_dirs[name] then
                    local found = scan(path, depth + 1)
                    if found then
                        return found
                    end
                end
            elseif type == "file"
                and (name:match("%.css$") or name:match("%.scss$") or name:match("%.pcss$"))
            then
                local f = io.open(path, "r")
                if f then
                    local content = f:read("*a")
                    f:close()
                    if content:find(target, 1, true) then
                        return path -- return first match
                    end
                end
            end
        end
        return nil
    end

    return scan(root, 0)
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
                    -- 只有在 tailwindcss LSP 真正启动时才去扫项目找全局 css，
                    -- 避免在 nvim 启动(spec)阶段就同步遍历整个工程目录树。
                    on_new_config = function(new_config)
                        new_config.settings.tailwindCSS.experimental.configFile =
                            find_tailwind_global_css()
                    end,
                    settings = {
                        tailwindCSS = {
                            classAttributes = { "class", "className", "ngClass" },
                            experimental = {
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
                    -- 新版 nvim-lspconfig 将 tsgo 并入 tsc 且优先使用本地 node_modules/.bin/tsc，
                    -- 但普通 tsc 不支持 --lsp 会直接 exit 1，这里强制只用 tsgo
                    cmd = function(dispatchers, config)
                        local cmd = "tsgo"
                        if config and config.root_dir then
                            local local_cmd =
                                vim.fs.joinpath(config.root_dir, "node_modules/.bin", "tsgo")
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
