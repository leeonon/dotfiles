-- tailwindcss LSP：入口 css 探测 + 保存时自动 quickfix
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
            elseif type == "file" and (name:match("%.css$") or name:match("%.scss$") or name:match("%.pcss$")) then
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

-- tialwindcss 保存时自动执行 code action 修复问题
local function apply_tailwind_quickfixes(client, bufnr)
    if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
        return
    end
    local ns = vim.lsp.diagnostic.get_namespace(client.id)
    local diagnostics = vim.diagnostic.get(bufnr, { namespace = ns })
    if #diagnostics == 0 then
        return
    end

    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = {
        only = { "quickfix" },
        diagnostics = vim.tbl_map(function(d)
            return {
                range = {
                    start = { line = d.lnum, character = d.col },
                    ["end"] = { line = d.end_lnum or d.lnum, character = d.end_col or d.col },
                },
                message = d.message,
                severity = d.severity,
                code = d.code,
                source = d.source,
            }
        end, diagnostics),
    }
    params.range = {
        start = { line = 0, character = 0 },
        ["end"] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
    }

    local response = client:request_sync("textDocument/codeAction", params, 1000, bufnr)
    local actions = response and response.result or {}
    for _, action in ipairs(actions) do
        if not action.edit and client:supports_method("codeAction/resolve") then
            local resolved = client:request_sync("codeAction/resolve", action, 1000, bufnr)
            if resolved and resolved.result then
                action = resolved.result
            end
        end
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        elseif action.command then
            client:exec_cmd(action.command, { bufnr = bufnr })
        end
    end
end

return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            tailwindcss = {
                -- 只有在 tailwindcss LSP 真正启动时才去扫项目找全局 css，
                -- 避免在 nvim 启动(spec)阶段就同步遍历整个工程目录树。
                on_new_config = function(new_config)
                    new_config.settings.tailwindCSS.experimental.configFile = find_tailwind_global_css()
                end,
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("LspTailwindFix_" .. bufnr, { clear = true }),
                        buffer = bufnr,
                        callback = function()
                            apply_tailwind_quickfixes(client, bufnr)
                        end,
                    })
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
        },
    },
}
