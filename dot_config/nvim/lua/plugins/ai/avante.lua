return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = true,
  enabled = true,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- provider = "claude",
    -- -- auto_suggestions_provider = "claude",
    -- claude = {
    --   endpoint = "https://api.anthropic.com",
    --   model = "claude-3-7-sonnet-20250219",
    --   temperature = 0,
    --   max_tokens = 4096,
    -- },
    provider = "deepseek",
    providers = {
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
      },
    },
    behaviour = {
      auto_focus_sidebar = true,
      -- auto_suggestions = false, -- Experimental stage
    },
  },

  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
