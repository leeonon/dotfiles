-- 参考https://github.com/mvpopuk/dotfiles/blob/main/nvim/lua/plugins/git.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        attach_to_untracked = true,
        -- 关闭 gitsigns 的行内 blame_line, 使用 git-blame.nvim
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },

        on_attach = function(bufnr)
          vim.keymap.set(
            "n",
            "<leader>H",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "Preview git hunk" }
          )

          vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { desc = "Gitsigns - Stage Hunk" })
          vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { desc = "Gitsigns - Reset Hunk" })
          vim.keymap.set("v", "<leader>hs", function()
            require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Gitsigns - Stage Hunk" })
          vim.keymap.set("v", "<leader>hr", function()
            require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Gitsigns - Reset Hunk" })
          vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { desc = "Gitsigns - Stage Buffer" })
          vim.keymap.set(
            "n",
            "<leader>hu",
            require("gitsigns").undo_stage_hunk,
            { desc = "Gitsigns - Undo Stage Hunk" }
          )
          vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { desc = "Gitsigns - Reset Buffer" })
          vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "Gitsigns - Preview Hunk" })
          vim.keymap.set("n", "<leader>hb", function()
            require("gitsigns").blame_line({ full = true })
          end, { desc = "Gitsigns - Blame Line" })
          vim.keymap.set(
            "n",
            "<leader>tb",
            require("gitsigns").toggle_current_line_blame,
            { desc = "Gitsigns - Toggle Blame Line" }
          )
          vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis, { desc = "Gitsigns - Diff This" })
          vim.keymap.set("n", "<leader>hD", function()
            require("gitsigns").diffthis("~")
          end, { desc = "Gitsigns - Diff This (cached)" })
          vim.keymap.set("n", "<leader>td", require("gitsigns").toggle_deleted, { desc = "Gitsigns - Toggle Deleted" })
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    -- opts = {
    --   setup = function()
    --     vim.keymap.set("n","<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
    --   end,
    -- },
  },
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- not git, but it's okay
  "mbbill/undotree",
}
