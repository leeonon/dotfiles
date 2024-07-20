return {
  "Wansmer/treesj",
  -- keys = { "<space>m", "<space>j", "<space>s" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({
      -- 禁用默认快捷键
      use_default_keymaps = false,
    })
    local wk = require("which-key")
    wk.add({
      {
        "<leader>nsj",
        function()
          require("treesj").toggle()
        end,
        desc = "Treesj-合并代码块",
      },
      {
        "<leader>nss",
        function()
          require("treesj").split()
        end,
        desc = "Treesj-拆分代码块",
      },
      {
        "<leader>nst",
        function()
          require("treesj").join()
        end,
        desc = "Treesj-自动检测拆分或合并代码块",
      },
    })
  end,
}
