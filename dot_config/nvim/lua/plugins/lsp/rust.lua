-- rust debug https://www.bilibili.com/video/BV1rf421S7ey
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    -- lazy = false, -- This plugin is already lazy
    ft = { "rust" },
    config = function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set("n", "<leader>rt", function()
        vim.cmd.RustLsp("openCargo")
      end, { silent = true, buffer = bufnr, desc = "打开Cargo.toml" })
      vim.keymap.set("n", "<leader>ct", function()
        vim.cmd.RustLsp("codeAction")
      end, { desc = "Code Action", buffer = bufnr })
      vim.keymap.set("n", "<leader>dr", function()
        vim.cmd.RustLsp("debuggables")
      end, { desc = "Rust Debuggables", buffer = bufnr })
    end,
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup({})
    end,
  },
}
