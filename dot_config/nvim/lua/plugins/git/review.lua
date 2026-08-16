return {
    "vuki656/review.nvim",
    config = function()
        require("review").setup({
            keymaps = { toggle = "<leader>rv" },
        })
    end,
}
