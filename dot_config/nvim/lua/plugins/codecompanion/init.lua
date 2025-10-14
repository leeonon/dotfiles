return {
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      --other plugins
      "ravitemer/codecompanion-history.nvim",
    },
  },
  {
    "olimorris/codecompanion.nvim", -- The KING of AI programming
    cmd = {
      "CodeCompanionChat",
      "CodeCompanion",
      "CodeCompanionCmd",
      "CodeCompanionActions",
    },
    event = "VeryLazy",
    init = function()
      require("utils/fidget-spinner"):init()

      require("legendary").keymaps({
        {
          itemgroup = "CodeCompanion",
          icon = "",
          description = "CodeCompanion AI",
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
    end,
    config = function()
      require("codecompanion").setup({
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = os.getenv("DEEPSEEK_API_KEY"),
              },
              schema = {
                model = {
                  default = "deepseek-chat",
                  -- default = "deepseek-reasoner",
                },
                temperature = {
                  default = 0.6, -- official recommendation
                },
              },
            })
          end,
        },
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
            -- adapter = "anthropic",
            adapter = "deepseek",
            keymap = {
              send = {
                modes = { n = "<C-s>", i = "<C-s>" },
              },
              close = {
                modes = { n = "<C-c>", i = "<C-c>" },
              },
            },
            slash_commands = require("plugins.codecompanion.slash_commands"),
          },
          inline = {
            -- adapter = "anthropic",
            adapter = "deepseek",
            keymaps = {
              accept_change = {
                modes = { n = "ga" },
                description = "Accept the suggested change",
              },
              reject_change = {
                modes = { n = "gr" },
                description = "Reject the suggested change",
              },
            },
          },
        },
        display = {
          chat = {
            icons = {
              pinned_buffer = "📌 ",
              watched_buffer = "👀 ",
            },
          },
        },
        opts = {
          language = "Zh",
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Automatically generate titles for new chats
              auto_generate_title = true,
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              -- Picker interface ("telescope" or "default")
              -- picker = "telescope",
              ---Enable detailed logging for history extension
              enable_logging = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>ah", "<cmd>CodeCompanionHistory<cr>", { desc = "Code Companion History" })
    end,
  },
}
