local link_char = "  "
return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            -- preset = "lazy", -- none | obsidian | lazy
            code = {
                sign = false,
                border = "thin",
                position = "right",
                width = "block",
                above = "▁",
                below = "▔",
                language_left = "█",
                language_right = "█",
                language_border = "▁",
                language_icon = true,
                left_pad = 1,
                right_pad = 1,
            },
            heading = {
                width = "block",
                backgrounds = {
                    "MiniStatusLineModeNormal",
                    "MiniStatusLineModeInsert",
                    "MiniStatusLineModeReplace",
                    "MiniStatusLineModeVisual",
                    "MiniStatusLineModeCommand",
                    "MiniStatusLineModeOther",
                },
                sign = true,
                left_pad = 1,
                right_pad = 0,
                position = "right",
                icons = {
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                },
            },
        },
        link = {
            image = "  ",
            email = "󰇮  ",
            hyperlink = link_char,
            custom = {
                web = { pattern = "^http", icon = link_char },
                sweb = { pattern = "^https", icon = link_char },
                linkedin = { pattern = "linkedin%.com", icon = "  " },
                youtube = { pattern = "youtube%.com", icon = "  " },
                github = { pattern = "github%.com", icon = "  " },
                stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌  " },
                discord = { pattern = "discord%.com", icon = "  " },
                reddit = { pattern = "reddit%.com", icon = "  " },
                acm = { pattern = "dl.acm%.org", icon = "  " },
                arxiv = { pattern = "arxiv%.org", icon = "  " },
            },
        },
        ft = { "markdown", "norg", "rmd", "org" },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            Snacks.toggle({
                name = "Render Markdown",
                get = function()
                    return require("render-markdown.state").enabled
                end,
                set = function(enabled)
                    local m = require("render-markdown")
                    if enabled then
                        m.enable()
                    else
                        m.disable()
                    end
                end,
            }):map("<leader>um")
        end,
    },
    {
        "brianhuster/live-preview.nvim",
        dependencies = {
            "folke/snacks.nvim",
        },
    },
}
