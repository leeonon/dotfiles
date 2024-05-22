return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  opts = {
    linters_by_ft = {
      -- eslint_d 有找不到配置文件的问题
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      -- javascript = { "eslint_d" },
      -- typescript = { "eslint_d" },
      -- javascriptreact = { "eslint_d" },
      -- typescriptreact = { "eslint_d" },
      -- svelte = { "eslint_d" },
      astro = { "eslint" },
      svelte = { "eslint" },
      python = { "pylint" },
    },
  },
}

