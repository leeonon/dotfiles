-- rust debug https://www.bilibili.com/video/BV1rf421S7ey
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false, -- This plugin is already lazy
    ft = { "rust" },
    config = function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set("n", "<leader>rt", function()
        vim.cmd.RustLsp("openCargo")
      end, { silent = true, buffer = bufnr, desc = "打开Cargo.toml" })
      -- vim.keymap.set(
      --   "n",
      --   "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
      --   function()
      --     vim.cmd.RustLsp({ "hover", "actions" })
      --   end,
      --   { silent = true, buffer = bufnr }
      -- )
      vim.keymap.set("n", "<leader>ct", function()
        vim.cmd.RustLsp("codeAction")
      end, { desc = "Code Action", buffer = bufnr })
      vim.keymap.set("n", "<leader>dr", function()
        vim.cmd.RustLsp("debuggables")
      end, { desc = "Rust Debuggables", buffer = bufnr })
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  -- RustOwl 可视化了变量的所有权转移和生命周期
  {
    "cordx56/rustowl",
    enabled = false,
    version = "*", -- Latest stable version
    build = "cargo binstall rustowl",
    lazy = false, -- This plugin is already lazy
    opts = {
      client = {
        on_attach = function(_, buffer)
          vim.keymap.set("n", "<leader>or", function()
            require("rustowl").toggle(buffer)
          end, { buffer = buffer, desc = "Toggle RustOwl" })
        end,
      },
    },
  },
}
