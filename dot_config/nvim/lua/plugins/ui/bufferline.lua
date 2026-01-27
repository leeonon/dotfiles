return {
  "akinsho/bufferline.nvim",
  enabled = false,
  config = function(_)
    vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { silent = true })
    vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { silent = true })
    vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { silent = true })
    vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { silent = true })
    vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { silent = true })
    vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { silent = true })
    vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { silent = true })
    vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { silent = true })
    vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { silent = true })
    require("bufferline").setup({
      options = {
        always_show_bufferline = false,
        themable = true,
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        -- numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        numbers = "none",
        indicator = {
          style = "icon",
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 14,
        offsets = {
          {
            filetype = "neo-tree",
            text = "  NEOTREE",
            highlight = "Directory",
            text_align = "left",
          },
        },
        separator_style = "thin", -- slant | padded_slant | slope | padded_slope | thin
      },
    })
  end,
}
