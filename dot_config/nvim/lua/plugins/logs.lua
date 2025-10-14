return {
  "gaelph/logsitter.nvim",
  enabled = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    vim.keymap.set("n", "<leader>lg", function()
      require("logsitter").log()
    end, {
      desc = "Log current line",
    })

    -- experimental visual mode
    vim.keymap.set("x", "<leader>lg", function()
      require("logsitter").log_visual()
    end)

    require("logsitter").setup({
      path_format = "fileonly",
      prefix = "[LOG] 🚀 ->",
      separator = "->",
    })
  end,
}
-- return {
--   "Goose97/timber.nvim",
--   version = "*", -- Use for stability; omit to use `main` branch for the latest features
--   event = "VeryLazy",
--   config = function()
--     require("timber").setup({
--       log_templates = {
--         default = {
--           lua = [[print("%filename:%log_target", %log_target)]],
--           javascript = [[console.log("log>>:%filename:%log_target", %log_target)]],
--           typescript = [[console.log("log>>:%filename:%log_target", %log_target)]],
--           astro = [[console.log("log>>:%filename:%log_target", %log_target)]],
--           jsx = [[console.log("log>>:%filename:%log_target", %log_target)]],
--           tsx = [[console.log("log>>:%filename:%log_target", %log_target)]],
--           svelte = [[console.log("log>>:%filename:%log_target", %log_target)]],
--         },
--       },
--     })
--   end,
-- }
