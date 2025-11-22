local config = {
  -- format = {
  --   insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true,
  --   insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
  --   semicolons = "remove",
  -- },
  -- implementationsCodeLens = {
  --   enabled = true,
  --   showOnInterfaceMethods = true,
  -- },
  inlayHints = {
    enumMemberValues = { enabled = false },
    functionLikeReturnTypes = { enabled = false },
    parameterNames = { enabled = "none" },
    parameterTypes = { enabled = false },
    propertyDeclarationTypes = { enabled = false },
    variableTypes = { enabled = false },
  },
  -- referencesCodeLens = {
  --   enabled = true,
  --   showOnAllFunctions = true,
  -- },
}

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
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
            -- useFlatConfig = true,
            -- experimental = {
            --   useFlatConfig = true,
            -- },
          },
          on_attach = function(client, bufnr)
            -- eslint auto fix on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
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
        tailwindcss = {
          settings = {
            tailwindCSS = {
              -- lint = {
              --   invalidApply = false,
              -- },
              classAttributes = { "class", "className", "ngClass" },
              experimental = {
                classRegex = {
                  "tw`([^`]*)", -- tw`...`
                  "tw='([^']*)", -- <div tw="..." />
                  "tw={`([^`}]*)", -- <div tw={"..."} />
                  "tw\\.\\w+`([^`]*)", -- tw.xxx`...`
                  "tw\\(.*?\\)`([^`]*)", -- tw(component)`...`
                  "styled\\(.*?, '([^']*)'\\)",
                  { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                  { "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                  { "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
                  { "{([\\s\\S]*)}", ":\\s*['\"`]([^'\"`]*)['\"`]" },
                },
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
        -- Svelte 无法识别 ts 文件类型变更
        -- https://github.com/sveltejs/language-tools/issues/2008#issuecomment-2898485264
        -- https://github.com/neovim/nvim-lspconfig/issues/725
        svelte = {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        },
        dart = {},
        cssmodules_ls = {
          enabled = false,
        },
        vtsls = {
          -- 使用 typescript-tools.nvim
          enabled = false,
          settings = {
            javascript = config,
            typescript = config,
          },
        },
      },
      -- 代码折叠相关
      -- capabilities = {
      --   textDocument = {
      --     foldingRange = {
      --       dynamicRegistration = false,
      --       lineFoldingOnly = true,
      --     },
      --   },
      -- },
    },
  },
  -- 展示 Lsp 加载进度UI
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
  },
}
