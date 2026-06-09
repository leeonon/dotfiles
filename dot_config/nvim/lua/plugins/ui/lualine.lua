local function getLspName()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
    local buf_ft = vim.bo.filetype
    if next(buf_clients) == nil then
        return "  No servers"
    end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    local lint_s, lint = pcall(require, "lint")
    if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
            if type(ft_v) == "table" then
                for _, linter in ipairs(ft_v) do
                    if buf_ft == ft_k then
                        table.insert(buf_client_names, linter)
                    end
                end
            elseif type(ft_v) == "string" then
                if buf_ft == ft_k then
                    table.insert(buf_client_names, ft_v)
                end
            end
        end
    end

    local ok, conform = pcall(require, "conform")
    local formatters = table.concat(conform.list_formatters_for_buffer(), " ")
    if ok then
        for formatter in formatters:gmatch("%w+") do
            if formatter then
                table.insert(buf_client_names, formatter)
            end
        end
    end
    --
    local hash = {}
    local unique_client_names = {}

    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
        end
    end
    local language_servers = table.concat(unique_client_names, ", ")

    return "  " .. language_servers
end

local colors = {
    rosewater = "#f2d5cf",
    flamingo = "#eebebe",
    pink = "#f4b8e4",
    mauve = "#ca9ee6",
    red = "#e78284",
    maroon = "#ea999c",
    peach = "#ef9f76",
    yellow = "#e5c890",
    green = "#a6d189",
    teal = "#81c8be",
    sky = "#99d1db",
    sapphire = "#85c1dc",
    blue = "#8caaee",
    lavender = "#babbf1",
    text = "#c6d0f5",
    subtext1 = "#b5bfe2",
    subtext0 = "#a5adce",
    overlay2 = "#949cbb",
    overlay1 = "#838ba7",
    overlay0 = "#737994",
    surface2 = "#626880",
    surface1 = "#51576d",
    surface0 = "#414559",
    base = "#303446",
    mantle = "#292c3c",
    crust = "#232634",
}

local icons = require("lazyvim.config").icons
return {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
        local auto = require("lualine.themes.auto")

        local function separator()
            return {
                function()
                    return " "
                end,
                color = { fg = colors.surface0, bg = "NONE", gui = "" },
                padding = { left = 1, right = 1 },
            }
        end

        local function custom_branch()
            local gitsigns = vim.b.gitsigns_head
            local fugitive = vim.fn.exists("*FugitiveHead") == 1 and vim.fn.FugitiveHead() or ""
            local branch = gitsigns or fugitive
            if branch == nil or branch == "" then
                return ""
            else
                return " " .. branch
            end
        end

        local modes = { "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }
        for _, mode in ipairs(modes) do
            if auto[mode] then
                for _, section in ipairs({ "a", "b", "c", "x", "y", "z" }) do
                    if auto[mode][section] then
                        auto[mode][section].bg = "NONE"
                    end
                end
            end
        end

        opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
            theme = auto,
            component_separators = "",
            section_separators = "",
            globalstatus = true,
            disabled_filetypes = { statusline = {}, winbar = {} },
        })

        opts.sections = {
            lualine_a = {
                {
                    "mode",
                    fmt = function(str)
                        -- return str:sub(1, 1)
                        return str
                    end,
                    color = function()
                        local mode = vim.fn.mode()
                        if mode == "\22" then
                            return { fg = "NONE", bg = colors.surface2, gui = "" }
                        elseif mode == "V" then
                            return { fg = colors.red, bg = "NONE", gui = "underline," }
                        else
                            return { fg = colors.red, bg = "NONE", gui = "" }
                        end
                    end,
                    padding = { left = 2, right = 0 },
                },
            },
            lualine_b = {
                separator(),
                {
                    custom_branch,
                    color = { fg = colors.surface2, bg = "NONE", gui = "" },
                    padding = { left = 0, right = 0 },
                },
                {
                    "diff",
                    colored = true,
                    diff_color = {
                        added = { fg = colors.surface0, bg = "NONE", gui = "" },
                        modified = { fg = colors.surface1, bg = "NONE", gui = "" },
                        removed = { fg = colors.surface2, bg = "NONE", gui = "" },
                    },
                    symbols = { added = "+", modified = "~", removed = "-" },
                    source = nil,
                    padding = { left = 1, right = 0 },
                },
            },
            lualine_c = {
                separator(),
                {
                    "filetype",
                    icon_only = true,
                    colored = false,
                    color = { fg = colors.surface2, bg = "NONE", gui = "" },
                    padding = { left = 0, right = 1 },
                },
                {
                    "filename",
                    file_status = true,
                    path = 0,
                    shorting_target = 20,
                    symbols = {
                        modified = "[+]",
                        readonly = "[-]",
                        unnamed = "[?]",
                        newfile = "[!]",
                    },
                    color = { fg = colors.surface2, bg = "NONE", gui = "" },
                    padding = { left = 0, right = 0 },
                },
                separator(),
                {
                    function()
                        local bufnr_list = vim.fn.getbufinfo({ buflisted = 1 })
                        local total = #bufnr_list
                        local current_bufnr = vim.api.nvim_get_current_buf()
                        local current_index = 0

                        for i, buf in ipairs(bufnr_list) do
                            if buf.bufnr == current_bufnr then
                                current_index = i
                                break
                            end
                        end

                        return string.format(" %d/%d", current_index, total)
                    end,
                    color = { fg = colors.surface2, bg = "NONE", gui = "" },
                    padding = { left = 0, right = 0 },
                },
            },
            lualine_x = {
                "searchcount",
                -- separator(),
                -- {
                --     require("lazy.status").updates,
                --     cond = require("lazy.status").has_updates,
                --     color = { fg = Snacks.util.color("Special"), bg = "NONE" },
                -- },
            },
            lualine_y = {
                { "lsp_progress" },
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic", "coc" },
                    sections = { "error", "warn", "info", "hint" },
                    cond = function()
                        return #vim.diagnostic.get(0) > 0
                    end,
                    diagnostics_color = {
                        error = { fg = colors.red },
                        warn = { fg = colors.yellow },
                        info = { fg = colors.purple },
                        hint = { fg = colors.cyan },
                    },
                    color = { bg = "NONE", gui = "" },
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                    padding = { left = 0, right = 0 },
                },
            },
            lualine_z = {
                separator(),
                {
                    function()
                        return getLspName()
                    end,
                    -- separator = { left = "", right = "" },
                    -- separator = { left = "", right = "" },
                    color = { bg = "NONE", fg = colors.surface2, gui = "" },
                },
            },
        }

        return opts
    end,
}
