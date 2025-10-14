return {
  -- 类似 IDE 的面包屑
  "Bekaboo/dropbar.nvim",
  enabled = false,
  config = function()
    local dropbar_api = require("dropbar.api")
    vim.keymap.set("n", "<Leader>;d", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
  end,
}
