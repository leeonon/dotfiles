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

local function find_tailwind_global_css()
  local target = "@import 'tailwindcss';"

  -- Find project root using `.git`
  local buf = vim.api.nvim_get_current_buf()
  local root = vim.fs.root(buf, function(name)
    return name == ".git"
  end)

  if not root then
    return nil -- no project root found
  end

  -- Find stylesheet files in the project root (recursively)
  local files = vim.fs.find(function(name)
    return name:match("%.css$") or name:match("%.scss$") or name:match("%.pcss$")
  end, {
    path = root,
    type = "file",
    limit = math.huge, -- search full tree
  })

  for _, path in ipairs(files) do
    local f = io.open(path, "r")
    if f then
      local content = f:read("*a")
      f:close()

      if content:find(target, 1, true) then
        return path -- return first match
      end
    end
  end

  return nil
end

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
              classAttributes = { "class", "className", "ngClass" },
              experimental = {
                -- configFile = "/Users/ly/code/github/molink/app/src/lib/styles/tailwind.css",
                -- TODO: 在 Tailwind v4 中寻找配置文件的解决方案，关注 PR 状态: https://github.com/neovim/nvim-lspconfig/pull/4222/files
                configFile = find_tailwind_global_css(),
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
          enabled = false,
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
          enabled = false,
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
    },
  },
  -- 展示 Lsp 加载进度UI
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
  },
}
