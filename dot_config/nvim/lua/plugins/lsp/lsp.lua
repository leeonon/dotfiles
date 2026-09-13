-- nvim-lspconfig 基础设置 + lua_ls
-- 各语言 server 配置见同目录 tailwind.lua / frontend.lua
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                virtual_text = false,
            },
            inlay_hints = {
                enabled = false,
                -- exclude = { "vue", "typescript", "javascript" }, -- filetypes for which you don't want to enable inlay hints
            },
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
            },
            setup = {
                lua_ls = function()
                    require("lspconfig.ui.windows").default_options.border = "single"
                end,
            },
        },
    },
    -- 展示 Lsp 加载进度UI
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
    },
}
