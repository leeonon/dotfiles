return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "BufEnter",
    opts = {
      suggestion = {
        -- https://github.com/zbirenbaum/copilot.lua/issues/91
        accept = false,
        -- enabled = true,
        -- auto_trigger = true,
        -- debounce = 150,
        -- keymap = {
        --   accept = "<M-;>",
        --   accept_word = false,
        --   accept_line = false,
        --   next = "<M-]>",
        --   prev = "<M-[>",
        --   dismiss = "<C-]>",
        -- },
      },
    },
  },
  {

    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    opts = {
      -- add any opts here
      provider = "copilot",
    },
    build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.icons",
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
        -- Make sure to setup it properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
