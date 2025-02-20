return {
  "olimorris/codecompanion.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  keys = {
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
  config = function()
    require("codecompanion").setup({
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
      },
    })
  end,
  init = function()
    require("utils/fidget-spinner"):init()
  end,
}
