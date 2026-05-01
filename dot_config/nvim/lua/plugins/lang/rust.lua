-- rust debug https://www.bilibili.com/video/BV1rf421S7ey
return {
    --  https://www.lazyvim.org/extras/lang/rust#rustaceanvim
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        lazy = false, -- This plugin is already lazy
        ft = { "rust" },
    },
    {
        "alexpasmantier/krust.nvim",
        ft = "rust",
        opts = {
            keymap = "<leader>k", -- Set a keymap for Rust buffers (default: false)
            float_win = {
                border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
                auto_focus = false, -- Auto-focus float (default: false)
            },
        },
    },
    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    -- RustOwl 可视化了变量的所有权转移和生命周期
    {
        "cordx56/rustowl",
        enabled = false,
        version = "*", -- Latest stable version
        build = "cargo binstall rustowl",
        lazy = false, -- This plugin is already lazy
        opts = {
            client = {
                on_attach = function(_, buffer)
                    vim.keymap.set("n", "<leader>or", function()
                        require("rustowl").toggle(buffer)
                    end, { buffer = buffer, desc = "Toggle RustOwl" })
                end,
            },
        },
    },
}
