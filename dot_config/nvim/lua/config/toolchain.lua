local M = {}

local prettier_files = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.mjs",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
}

local oxfmt_files = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts", "oxfmt.config.mts" }
local oxlint_files = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" }
local biome_files = { "biome.json", "biome.jsonc" }
local eslint_files = {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
}

local function file_dir(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then
        return vim.uv.cwd()
    end
    return vim.fs.dirname(name)
end

local function project_root(bufnr)
    return vim.fs.root(bufnr, { ".git", "bun.lock", "package-lock.json", "pnpm-lock.yaml", "yarn.lock" })
        or vim.uv.cwd()
end

function M.find_up(bufnr, names)
    local start = file_dir(bufnr)
    local root = project_root(bufnr)
    local stop = root and vim.fs.dirname(root) or nil
    return vim.fs.find(names, {
        upward = true,
        path = start,
        stop = stop,
        type = "file",
        limit = 1,
    })[1]
end

function M.has_bin(bufnr, bin)
    local start = file_dir(bufnr)
    local stop = project_root(bufnr)
    local dir = start
    while dir do
        if vim.fn.executable(vim.fs.joinpath(dir, "node_modules", ".bin", bin)) == 1 then
            return true
        end
        if dir == stop then
            break
        end
        local parent = vim.fs.dirname(dir)
        if parent == dir then
            break
        end
        dir = parent
    end
    return false
end

function M.has_oxfmt(bufnr)
    return M.find_up(bufnr, oxfmt_files) ~= nil or M.has_bin(bufnr, "oxfmt")
end

function M.has_oxlint(bufnr)
    return M.find_up(bufnr, oxlint_files) ~= nil or M.has_bin(bufnr, "oxlint")
end

function M.has_biome(bufnr)
    return M.find_up(bufnr, biome_files) ~= nil
end

function M.has_prettier(bufnr)
    return M.find_up(bufnr, prettier_files) ~= nil
end

function M.has_eslint(bufnr)
    return M.find_up(bufnr, eslint_files) ~= nil
end

function M.formatter(bufnr, default)
    if M.has_oxfmt(bufnr) then
        return { "oxfmt", stop_after_first = true }
    end
    if M.has_biome(bufnr) then
        return { "biome", stop_after_first = true }
    end
    if M.has_prettier(bufnr) then
        return { "prettierd", stop_after_first = true }
    end
    return default or {}
end

return M
