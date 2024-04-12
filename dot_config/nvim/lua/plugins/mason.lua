return {
  "williamboman/mason.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = '✅',
        package_pending = '➡️',
        package_uninstalled = '❌',
      }
    },
    ensure_installed = {
      "lua-language-server",
      'prettierd',
      "flake8",
      "stylua",
      "selene",
      "luacheck",
      "shellcheck",
      "shfmt",
      "tailwindcss-language-server",
      "typescript-language-server",
      "css-lsp",
      "html-lsp",
      "htmlhint"
    },
  },
}