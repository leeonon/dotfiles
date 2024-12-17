-- return {
--   "gaelph/logsitter.nvim",
--   dependencies = { "nvim-treesitter/nvim-treesitter" },
--   config = function()
--     vim.keymap.set("n", "<leader>lg", function()
--       require("logsitter").log()
--     end, {
--       desc = "Log current line",
--     })
--
--     -- experimental visual mode
--     vim.keymap.set("x", "<leader>lg", function()
--       require("logsitter").log_visual()
--     end)
--
--     require("logsitter").setup({
--       path_format = "fileonly",
--       prefix = "[LS] 🚀 ->",
--       separator = "->",
--     })
--   end,
-- }
return {
  "Goose97/timber.nvim",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("timber").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
