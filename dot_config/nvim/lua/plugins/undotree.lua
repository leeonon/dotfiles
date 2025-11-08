return {
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
    end,
  },
}
