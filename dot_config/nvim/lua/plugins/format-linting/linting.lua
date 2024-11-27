return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      svelte = { "eslint" },
      python = { "pylint" },
      astro = { "eslint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint(nil, {
          ignore_errors = true, -- 忽略没有找到 eslint 配置文件时的错误
        })
      end,
    })

    vim.keymap.set("n", "<leader>ce", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
