return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      setup = {
        -- https://github.com/mrcjkb/rustaceanvim/blob/master/doc/mason.txt
        rust_analyzer = function()
          return true
        end,
        lua_ls = function()
          require("lspconfig.ui.windows").default_options.border = "single"
        end,
      },
      inlay_hints = {
        enabled = false,
        -- exclude = { "vue", "typescript", "javascript" }, -- filetypes for which you don't want to enable inlay hints
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
        tailwindcss = {
          settings = {
            tailwindCSS = {
              lint = {
                invalidApply = false,
              },
            },
          },
        },
        volar = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
      },
      -- 代码折叠相关
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    },
  },
}
