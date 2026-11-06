return {
    "Mirsmog/real-icons.nvim",
    build = ":RealIcons install",
    opts = {
        integrations = {
            neo_tree = false,
            mini_files = false,
            fzf_lua = false,
            snacks_picker = true,
            lualine = false,
        },
    },
}
