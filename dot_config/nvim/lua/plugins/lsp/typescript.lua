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

---@module 'lazy'
---@type LazySpec[]
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            javascript = config,
            typescript = config,
          },
        },
      },
    },
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
    keys = function()
      return {
        {
          "<leader>tk",
          function()
            require("pretty_hover").hover()
          end,
          desc = "Hover documentation",
        },
      }
    end,
  },
  -- {
  --   "youyoumu/pretty-ts-errors.nvim",
  --   opts = {
  --     -- your configuration options
  --   },
  -- },
}
