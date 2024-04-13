return {
  "neovim/nvim-lspconfig",
}

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