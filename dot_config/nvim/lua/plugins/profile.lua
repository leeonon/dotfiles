return {
  "Kurama622/profile.nvim",
  enabled = false,
  dependencies = { "3rd/image.nvim" },
  config = function()
    require("profile").setup({
      avatar_path = "~/.config/nvim/images/avatar.png",
    })
    vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>Profile<cr>", { silent = true })
  end,
}
