return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  ---@module "quicker"
  opts = {
    type_icons = {
      E = " ",
      W = " ",
      I = " ",
      N = " ",
      H = " ",
    },
    keys = {
      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },
  },
  config = function()
    vim.keymap.set("n", "<leader>qf", function()
      require("quicker").toggle()
    end, {
      desc = "Toggle quickfix",
    })
    vim.keymap.set("n", "<leader>l", function()
      require("quicker").toggle({ loclist = true })
    end, {
      desc = "Toggle loclist",
    })
    require("quicker").setup({
      borders = {
        vert = " ┃ ",
        strong_header = "━",
        strong_cross = "╋",
        strong_end = "┫",
        soft_header = "╌",
        soft_cross = "╂",
        soft_end = "┨",
      },
    })
  end,
}
