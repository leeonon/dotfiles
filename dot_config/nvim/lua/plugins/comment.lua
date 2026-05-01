return {
    {
        "Cartoone9/pretty-comment.nvim",
        --    ╭────────────────────────────────────────────╮
        --    │            Recommended keybinds            │
        --    ╰────────────────────────────────────────────╯
        keys = {
            { "gcb", ":CommentBox<CR>", mode = "v", desc = "Comment box", silent = true },
            { "gcb", "<cmd>CommentBox<CR>", mode = "n", desc = "Comment box (line)", silent = true },
            { "gcB", ":CommentBoxFat<CR>", mode = "v", desc = "Fat comment box", silent = true },
            { "gcB", "<cmd>CommentBoxFat<CR>", mode = "n", desc = "Fat comment box (line)", silent = true },
            { "gcl", ":CommentLine<CR>", mode = "v", desc = "Centered title line", silent = true },
            { "gcl", "<cmd>CommentLine<CR>", mode = "n", desc = "Centered title line (line)", silent = true },
            { "gcL", ":CommentLineFat<CR>", mode = "v", desc = "Fat centered title line", silent = true },
            { "gcL", "<cmd>CommentLineFat<CR>", mode = "n", desc = "Fat centered title line (line)", silent = true },
            { "gcs", "<cmd>CommentSep<CR>", mode = "n", desc = "Comment separator", silent = true },
            { "gcS", "<cmd>CommentSepFat<CR>", mode = "n", desc = "Fat comment separator", silent = true },
            { "gcd", "<cmd>CommentDiv<CR>", mode = "n", desc = "Comment divider", silent = true },
            { "gcD", "<cmd>CommentDivFat<CR>", mode = "n", desc = "Fat comment divider", silent = true },
            { "gcr", ":CommentRemove<CR>", mode = "v", desc = "Strip comment decoration", silent = true },
            { "gcr", "<cmd>CommentRemove<CR>", mode = "n", desc = "Strip comment decoration (line)", silent = true },
            {
                "gce",
                ":CommentEqualize<CR>",
                mode = "v",
                desc = "Equalize comment decoration (selection)",
                silent = true,
            },
            { "gce", "<cmd>CommentEqualize<CR>", mode = "n", desc = "Equalize all comment decoration", silent = true },
            { "gcx", "<cmd>CommentReset<CR>", mode = "n", desc = "Reset comment width tracking", silent = true },
        },
        --  ───────────────────────────────────────────────────────────────────────────────────────────────────
        --    ╭─────────────────────────────────────────────────────────────────────────────────────────────╮
        --    │          gc* keybinds above add a delay to visual 'gc' comment toggle. Use 'gcc'            │
        --    │                        in visual mode to toggle comments instantly.                         │
        --    ╰─────────────────────────────────────────────────────────────────────────────────────────────╯
        init = function()
            vim.keymap.set("x", "gcc", function()
                return require("vim._comment").operator()
            end, { expr = true, desc = "Comment toggle (instant, avoids gc delay)" })
        end,
        --  ───────────────────────────────────────────────────────────────────────────────────────────────────
        config = function(_, opts)
            require("pretty-comment").setup(opts)
        end,
        opts = {},
    },
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({})
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "gcg", ":lua require('neogen').generate()<CR>", opts)
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },
}
