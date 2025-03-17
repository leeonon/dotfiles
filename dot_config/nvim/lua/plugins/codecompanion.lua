-- return {
--   "olimorris/codecompanion.nvim",
--   enabled = true,
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--     "j-hui/fidget.nvim",
--   },
--   keys = {
--     {
--       "<leader>ac",
--       "<cmd>CodeCompanionActions<cr>",
--       mode = { "n", "v" },
--       desc = "Code Companion Actions",
--     },
--     {
--       "<leader>aa",
--       "<cmd>CodeCompanionChat Toggle<cr>",
--       mode = { "n", "v" },
--       desc = "Code Companion Chat Toggle",
--     },
--     { "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, desc = "Code Companion Chat Add" },
--     { "<leader>ab", "<cmd>CodeCompanion", mode = { "v" } },
--   },
--   config = function()
--     require("codecompanion").setup({
--       strategies = {
--         chat = {
--           adapter = "anthropic",
--           keymap = {
--             send = {
--               modes = { n = "<C-s>", i = "<C-s>" },
--             },
--             close = {
--               modes = { n = "<C-c>", i = "<C-c>" },
--             },
--           },
--         },
--         inline = {
--           adapter = "anthropic",
--         },
--       },
--       opts = {
--         language = "Zh",
--       },
--       prompt_library = {
--         ["自定义Prompt"] = {
--           strategy = "chat",
--           description = "Some cool custom prompt you can do",
--           prompts = {
--             {
--               role = "system",
--               content = "You are an experienced developer with Lua and Neovim",
--             },
--             {
--               role = "user",
--               content = "Can you explain why ...",
--             },
--           },
--         },
--       },
--     })
--   end,
--   init = function()
--     require("utils/fidget-spinner"):init()
--   end,
-- }

return {
  "olimorris/codecompanion.nvim", -- The KING of AI programming
  dependencies = {
    "j-hui/fidget.nvim",
  },
  opts = {
    adapters = {},
    prompt_library = {
      ["自定义Prompt"] = {
        strategy = "chat",
        description = "Some cool custom prompt you can do",
        prompts = {
          {
            role = "system",
            content = "You are an experienced developer with Lua and Neovim",
          },
          {
            role = "user",
            content = "Can you explain why ...",
          },
        },
      },
      ["测试工作流"] = {
        strategy = "workflow",
        description = "Use a workflow to test the plugin",
        opts = {
          index = 4,
        },
        prompts = {
          {
            {
              role = "user",
              content = "Generate a Python class for managing a book library with methods for adding, removing, and searching books",
              opts = {
                auto_submit = false,
              },
            },
          },
          {
            {
              role = "user",
              content = "Write unit tests for the library class you just created",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Create a TypeScript interface for a complex e-commerce shopping cart system",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Write a recursive algorithm to balance a binary search tree in Java",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Generate a comprehensive regex pattern to validate email addresses with explanations",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Create a Rust struct and implementation for a thread-safe message queue",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Write a GitHub Actions workflow file for CI/CD with multiple stages",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Create SQL queries for a complex database schema with joins across 4 tables",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Write a Lua configuration for Neovim with custom keybindings and plugins",
              opts = {
                auto_submit = true,
              },
            },
          },
          {
            {
              role = "user",
              content = "Generate documentation in JSDoc format for a complex JavaScript API client",
              opts = {
                auto_submit = true,
              },
            },
          },
        },
      },
    },
    strategies = {
      chat = {
        adapter = "anthropic",
        keymap = {
          send = {
            modes = { n = "<C-s>", i = "<C-s>" },
          },
          close = {
            modes = { n = "<C-c>", i = "<C-c>" },
          },
        },
      },
      inline = {
        adapter = "anthropic",
      },
    },
    opts = {
      language = "Zh",
    },
  },
  init = function()
    require("legendary").keymaps({
      {
        itemgroup = "CodeCompanion",
        icon = "",
        description = "打开AI",
        keymaps = {
          {
            "<leader>ac",
            "<cmd>CodeCompanionActions<cr>",
            mode = { "n", "v" },
            desc = "Code Companion Actions",
          },
          {
            "<leader>aa",
            "<cmd>CodeCompanionChat Toggle<cr>",
            mode = { "n", "v" },
            desc = "Code Companion Chat Toggle",
          },
          { "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, desc = "Code Companion Chat Add" },
          { "<leader>ab", "<cmd>CodeCompanion", mode = { "v" } },
        },
      },
    })
    require("utils/fidget-spinner"):init()
  end,
}
