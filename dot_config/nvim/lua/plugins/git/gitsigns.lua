return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  event = "InsertEnter",
  config = function()
    require("gitsigns").setup({
      -- 显示行内单词差异
      word_diff = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { buffer = bufnr, desc = "Next Hunk" })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)
        -- vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
        -- vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
        --
        -- vim.keymap.set("v", "<leader>hs", function()
        --   gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        -- end, { desc = "Stage Hunk" })
        --
        -- vim.keymap.set("v", "<leader>hr", function()
        --   gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        -- end, { desc = "Reset Hunk" })
        --
        -- vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { buffer = bufnr, desc = "Stage Buffer" })
        -- vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Reset Buffer" })
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
        vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline)

        vim.keymap.set("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end)

        vim.keymap.set("n", "<leader>hd", gitsigns.diffthis)

        vim.keymap.set("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, { desc = "Diff this against HEAD" })

        vim.keymap.set("n", "<leader>hQ", function()
          gitsigns.setqflist("all")
        end, { desc = "Set QF List for all hunks" })
        vim.keymap.set("n", "<leader>hq", gitsigns.setqflist, { desc = "Set QF List for current hunk" })
        vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle Blame" })
        vim.keymap.set("n", "<leader>tw", gitsigns.toggle_word_diff, { buffer = bufnr, desc = "Toggle Word Diff" })

        vim.keymap.set("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, { buffer = bufnr, desc = "Diff this against HEAD" })
      end,
    })
  end,
}
