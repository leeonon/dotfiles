return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        image = {
            enabled = true,
        },
        gitbrowse = {
            -- your gitbrowse configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        terminal = {
            win = {
                -- position = "bottom",
            },
        },
        dashboard = require("utils.dashboard"),
        indent = {
            enabled = false,
        },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = false },
        words = { enabled = true },
        input = {
            enabled = true,
            icon = " ",
            icon_hl = "SnacksInputIcon",
            icon_pos = "left",
            prompt_pos = "title",
            win = { style = "input" },
            expand = true,
        },
        picker = {
            enabled = true,
            prompt = "[SNACKS] ",
            border = "none",
            -- layout = "telescope_one",
            layout = "telescope_default",
            layouts = {
                -- The default layout for "telescopy" pickers, e.g. `files`, `commands`, ...
                telescope_default = {
                    preset = function()
                        return vim.o.columns >= 100 and "telescope" or "vertical"
                    end,
                    layout = {
                        backdrop = false,
                    },
                },
                telescope_one = {
                    layout = {
                        box = "horizontal",
                        backdrop = false,
                        width = 0.8,
                        height = 0.9,
                        border = "none",
                        {
                            box = "vertical",
                            {
                                win = "input",
                                height = 1,
                                border = "rounded",
                                title = "{title} {live} {flags}",
                                title_pos = "center",
                            },
                            { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                        },
                        {
                            win = "preview",
                            title = "{preview:Preview}",
                            width = 0.45,
                            border = "rounded",
                            title_pos = "center",
                        },
                    },
                },
            },
        },
        scratch = {
            enabled = false,
        },
        zen = {
            toggles = {
                dim = true,
                git_signs = true,
                mini_diff_signs = false,
                -- diagnostics = false,
                -- inlay_hints = false,
            },
            show = {
                statusline = false, -- can only be shown when using the global statusline
                tabline = false,
            },
            zoom = {
                toggles = {},
                show = { statusline = false, tabline = false },
                win = {
                    backdrop = false,
                    width = 0, -- full width
                },
            },
        },
    },
    -- lazy snacls picker 默认快捷键 - https://www.lazyvim.org/extras/editor/snacks_picker
    keys = {
        {
            "<leader>,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>.",
            nil,
        },
        {
            "<leader>S",
            nil,
        },
    },
    init = function()
        vim.b.miniindentscope_disable = true

        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    -- Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                -- Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
                vim.api.nvim_set_hl(0, "SnacksInputTitle", { bg = "none", nocombine = true })
                vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#45475a", bg = "NONE", nocombine = true })
                vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = "#45475a", bg = "NONE", nocombine = true })
                vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#45475A", bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksPickerTitle", { bg = "#7aa2f7" })
                vim.api.nvim_set_hl(0, "SnacksPickerPreview", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksPickerList", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksPickerListTitle", { bg = "#9ece6a" })
                vim.api.nvim_set_hl(0, "SnacksPickerInputTitle", { bg = "#f7768e", fg = "#45475a" })
                vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { bg = "NONE", fg = "#45475a" })
                vim.api.nvim_set_hl(0, "SnacksPickerInputSearch", { bg = "#f7768e" })
                vim.api.nvim_set_hl(0, "SnacksPickerInput", { bg = "NONE" })
            end,
        })
    end,
}
