---@module 'lazy'
---@type LazySpec[]
return {
    -- {
    --     "Sebastian-Nielsen/better-type-hover",
    --     ft = { "typescript", "typescriptreact" },
    --     config = function()
    --         require("better-type-hover").setup()
    --     end,
    -- },

    --     "pmizio/typescript-tools.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --     opts = {},
    -- },
    {
        "enochchau/nvim-pretty-ts-errors",
        build = "npm install",
    },
    -- {
    --   "Fildo7525/pretty_hover",
    --   event = "LspAttach",
    --   opts = {},
    --   keys = function()
    --     return {
    --       {
    --         "<leader>tk",
    --         function()
    --           require("pretty_hover").hover()
    --         end,
    --         desc = "Hover documentation",
    --       },
    --     }
    --   end,
    -- },
}
