return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {
        settings = {
          useFlatConfig = true
        },
        workingDirectories = { mode = "auto" },
      },
      ["rust_analyzer"] = {
        settings = {
          cargo = { allFeatures = true },
          hint = { enable = true },
        },
      },
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
}