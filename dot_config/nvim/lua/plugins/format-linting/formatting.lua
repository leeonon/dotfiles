-- conform 格式化配置

-- Biome 支持 https://github.com/LazyVim/LazyVim/issues/2116

local function find_config(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]
end

local function biome_or_prettier(bufnr)
  local has_biome_config = find_config(bufnr, { "biome.json", "biome.jsonc" })
  if has_biome_config then
    return { "biome", stop_after_first = true }
  end

  local has_prettier_config = find_config(bufnr, {
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
  })
  if has_prettier_config then
    return { "prettierd", stop_after_first = true }
  end

  -- Default to Prettier if no config is found
  return {}
end

local supported = {
  "astro",
  "css",
  "graphql",
  -- "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  -- "markdown",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
  -- "yaml",
}

return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      biome = {
        require_cwd = true,
      },
    },
    formatters_by_ft = {
      javascript = biome_or_prettier,
      typescript = biome_or_prettier,
      javascriptreact = biome_or_prettier,
      typescriptreact = biome_or_prettier,
      svelte = biome_or_prettier,
      css = { "prettierd" },
      less = { "stylelint" },
      html = biome_or_prettier,
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      dart = { "dart_format" },
    },
  },
}
