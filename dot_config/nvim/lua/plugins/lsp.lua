return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["rust_analyzer"] = {
        settings = {
          cargo = { allFeatures = true },
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

-- opts = {
---@type lspconfig.options
-- servers = {
--   eslint = {
--     settings = {
--       experimental = {
--         -- 开启 flat config 支持
--         useFlatConfig = true,
--       },
--       -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
--       -- workingDirectories = { mode = "auto" },
--     },
--   },
-- },
--   -- },
-- }

-- -- 禁用 eslint 保存自动修复
--   -- opts = {
--   --   servers = { eslint = {} },
--   --   setup = {
--   --     eslint = function()
--   --       require("lazyvim.util").lsp.on_attach(function(client)
--   --         -- if client.name == "eslint" then
--   --         --   client.server_capabilities.documentFormattingProvider = true
--   --         -- elseif client.name == "tsserver" then
--   --         --   client.server_capabilities.documentFormattingProvider = true
--   --         -- end
--   --       end)
--   --     end,
--   --   },
--   -- },
