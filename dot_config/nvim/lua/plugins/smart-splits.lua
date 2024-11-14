return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup({
      default_amount = 3,
    })
    vim.keymap.set("n", "<C-A-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<C-A-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<C-A-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<C-A-l>", require("smart-splits").resize_right)
    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
    vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
    -- swapping buffers between windows
    vim.keymap.set("n", "<leader>wh", require("smart-splits").swap_buf_left, {
      desc = "Swap buffer to the left",
    })
    vim.keymap.set("n", "<leader>wj", require("smart-splits").swap_buf_down, {
      desc = "Swap buffer to the bottom",
    })
    vim.keymap.set("n", "<leader>wk", require("smart-splits").swap_buf_up, {
      desc = "Swap buffer to the top",
    })
    vim.keymap.set("n", "<leader>wl", require("smart-splits").swap_buf_right, {
      desc = "Swap buffer to the right",
    })
  end,
}
