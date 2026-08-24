return {
    "serhez/bento.nvim",
    branch = "feat/v2",
    config = function()
        require("bento").setup({
            lock_char = "🔒", -- Character shown before locked buffer names
            max_open_buffers = nil, -- Max buffers (nil = unlimited)
            buffer_deletion_metric = "frecency_access", -- Metric for buffer deletion
            buffer_notify_on_delete = true, -- Notify when deleting a buffer
            ordering_metric = "access", -- nil | "access" | "edit" | "filename" | "directory"
            locked_first = false, -- Sort locked buffers to the top
            map_last_accessed = false,

            ui = {
                mode = "floating", -- "floating" | "tabline"
                floating = {
                    position = "middle-right",
                    offset_x = 0,
                    offset_y = 0,
                    dash_char = "─",
                    border = "none",
                    label_padding = 1,
                    minimal_menu = "dashed", -- nil | "dashed" | "filename" | "full"
                    max_rendered_buffers = nil,
                },
                tabline = {
                    left_page_symbol = "❮",
                    right_page_symbol = "❯",
                    separator_symbol = "│",
                },
            },

            highlights = {
                current = "Bold",
                active = "Normal",
                inactive = "Comment",
                modified = "DiagnosticWarn",
                inactive_dash = "Comment",
                previous = "Search",
                label = "DiagnosticVirtualTextHint",
                label_minimal = "Visual",
                window_bg = "BentoNormal",
                page_indicator = "Comment",
                separator = "Normal",
            },
        })

        local api = require("bento.api")

        -- Register menu keymaps (official README setup)
        api.register_expand_key(";") -- Open/expand menu
        api.register_last_buffer_key(";") -- Same as expand key: ";;" switches to last buffer
        api.register_collapse_key("<Esc>") -- Collapse/close menu
        api.register_prev_page_key("[") -- Previous page (pagination)
        api.register_next_page_key("]") -- Next page (pagination)

        -- Register built-in actions
        api.register_action("open", {
            key = "<CR>",
            action = api.actions.open,
            hl = "DiagnosticVirtualTextHint",
        })
        api.register_action("delete", {
            key = "<BS>",
            action = api.actions.delete,
            hl = "DiagnosticVirtualTextError",
        })
        api.register_action("vsplit", {
            key = "|",
            action = api.actions.vsplit,
            hl = "DiagnosticVirtualTextInfo",
        })
        api.register_action("split", {
            key = "_",
            action = api.actions.split,
            hl = "DiagnosticVirtualTextInfo",
        })
        api.register_action("lock", {
            key = "*",
            action = api.actions.lock,
            hl = "DiagnosticVirtualTextWarn",
        })

        api.set_default_action("open")
    end,
}
