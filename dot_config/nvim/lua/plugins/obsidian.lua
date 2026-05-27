return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    config = function(_)
        require("obsidian").setup({
            picker = {
                name = "snacks.pick", -- use snacks picker
                -- name = "telescope.nvim",   -- or telescope
                -- name = "fzf-lua",     -- or fzf-lua
                -- name = "mini.pick",   -- or mini.pick
            },
            legacy_commands = false, -- this will be removed in 4.0.0
            workspaces = {
                {
                    name = "LeeOnOnObsidian",
                    path = "~/code/github/LeeOnOnObsidian/content",
                },
            },
        })
    end,
}
