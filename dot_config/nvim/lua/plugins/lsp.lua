return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        -- https://github.com/mrcjkb/rustaceanvim/blob/master/doc/mason.txt
        rust_analyzer = function()
          return true
        end,
      },
      servers = {
        -- eslint = {
        --   settings = {
        --     useFlatConfig = true,
        --   },
        --   workingDirectories = { mode = "auto" },
        -- },
        -- ["rust_analyzer"] = {
        --   settings = {
        --     cargo = { allFeatures = true },
        --     hint = { enable = true },
        --     checkOnSave = { command = "clippy" },
        --   },
        -- },
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
    },
  },
}
