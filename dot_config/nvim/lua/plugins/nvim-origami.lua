return {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {}, -- required even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.fillchars = {
            fold = " ",
            foldopen = "",
            foldclose = "",
            foldsep = " ",
        }

        -- default settings
        require("origami").setup({
            useLspFoldsWithTreesitterFallback = {
                enabled = true,
                foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
            },
            pauseFoldsOnSearch = true,
            foldtext = {
                enabled = true,
                padding = {
                    character = " ",
                    width = 3, ---@type number|fun(win: number, foldstart: number, currentVirtualTextLength: number): number
                    hlgroup = nil,
                },
                lineCount = {
                    template = "󰘖 %d lines", -- `%d` is replaced with the number of folded lines
                    hlgroup = "Comment",
                },
                diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
                gitsignsCount = true, -- requires `gitsigns.nvim`
                disableOnFt = { "snacks_picker_input" }, ---@type string[]
            },
            autoFold = {
                enabled = true,
                kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
            },
            foldKeymaps = {
                setup = true, -- modifies `h`, `l`, `^`, and `$`
                closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
                scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
            },
        })
    end,
}
