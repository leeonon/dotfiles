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

-- 从一个 code action 里取出属于当前 buffer 的 text edits
local function action_text_edits(action, uri)
    local edit = action.edit
    if not edit then
        return nil
    end
    if edit.changes then
        return edit.changes[uri]
    end
    if edit.documentChanges then
        local edits = {}
        for _, change in ipairs(edit.documentChanges) do
            -- 带 textDocument 的才是 TextDocumentEdit，其余是 CreateFile/RenameFile 等资源操作
            if change.textDocument and change.textDocument.uri == uri and change.edits then
                vim.list_extend(edits, change.edits)
            end
        end
        return edits
    end
    return nil
end

local function pos_le(a, b)
    return a.line < b.line or (a.line == b.line and a.character <= b.character)
end

local function ranges_overlap(a, b)
    return pos_le(a.range.start, b.range["end"]) and pos_le(b.range.start, a.range["end"])
end

-- tialwindcss 保存时自动执行 code action 修复问题
--
-- 这里只能「收集全部 edits → 一次性 apply_text_edits」，不能 for 循环逐条
-- apply_workspace_edit。tailwind LSP 的 canonical class quickfix 会把
-- `left-[calc(var(--sidebar-width)*-1)]` 改写成更短的 `-left-(--sidebar-width)`，
-- 逐条应用时后一条的 range 仍按「改动前」的文本算，offset 一路漂移，
-- 会把同一行后面的类名和行尾引号一起吃掉（曾把 admin 的 sidebar.tsx 写坏过）。
local function apply_tailwind_quickfixes(client, bufnr)
    if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
        return
    end
    if not vim.api.nvim_buf_is_loaded(bufnr) then
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

    local ok, response = pcall(client.request_sync, client, "textDocument/codeAction", params, 1000, bufnr)
    if not ok or not response or not response.result then
        return
    end

    local uri = vim.uri_from_bufnr(bufnr)
    local edits, accepted, commands = {}, {}, {}
    for _, action in ipairs(response.result) do
        if not action.edit and client:supports_method("codeAction/resolve") then
            local resolved = client:request_sync("codeAction/resolve", action, 1000, bufnr)
            if resolved and resolved.result then
                action = resolved.result
            end
        end

        local action_edits = action_text_edits(action, uri)
        if action_edits then
            for _, edit in ipairs(action_edits) do
                -- 多个 action 可能给出重复或互相重叠的 range，重叠的必须丢掉，
                -- 否则同一个位置被写两次照样会错位。
                local dup = false
                for _, kept in ipairs(accepted) do
                    if ranges_overlap(edit, kept) then
                        dup = true
                        break
                    end
                end
                if not dup then
                    accepted[#accepted + 1] = edit
                    edits[#edits + 1] = edit
                end
            end
        elseif action.command then
            commands[#commands + 1] = action.command
        end
    end

    if #edits > 0 then
        vim.lsp.util.apply_text_edits(edits, bufnr, client.offset_encoding)
    end
    for _, command in ipairs(commands) do
        client:exec_cmd(command, { bufnr = bufnr })
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
