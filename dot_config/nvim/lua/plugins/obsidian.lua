return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function(_, opts)
    require("obsidian").setup({
      workspaces = {
        {
          name = "LeeOnOnObsidian",
          path = "~/code/github/LeeOnOnObsidian/content",
        },
      },
      ui = {
        -- Markdowon 渲染交给 render-markdown 插件
        ui = { enable = false },
      },
      footer = {
        enabled = true,
        format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
        hl_group = "Comment",
        separator = string.rep("-", 80),
      },

      callbacks = {
        enter_note = function(_, note)
          vim.keymap.set("n", "<leader>oh", "<cmd>Obsidian toggle_checkbox<cr>", {
            buffer = note.bufnr,
            desc = "OB:Toggle checkbox",
          })
          vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian backlinks<cr>", {
            buffer = note.bufnr,
            desc = "OB:Backlinks",
          })
          vim.keymap.set("n", "<leader>oL", "<cmd>Obsidian links<cr>", {
            buffer = note.bufnr,
            desc = "OB:Links",
          })
          vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<cr>", {
            buffer = note.bufnr,
            desc = "OB:New",
          })
          vim.keymap.set("n", "<leader>oP", "<cmd>Obsidian Paste_img<cr>", {
            buffer = note.bufnr,
            desc = "OB:Paste image",
          })
        end,
      },
    })
  end,
}
