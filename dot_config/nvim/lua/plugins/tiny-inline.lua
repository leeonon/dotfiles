return {
  -- 同步修改 vim.diagnostic.config({ virtual_text = false })
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    enabled = true,
    config = function()
      require("tiny-inline-diagnostic").setup({
        -- "modern", "classic", "minimal", "powerline",
        -- "ghost", "simple", "nonerdfont", "amongus"
        preset = "amongus",
        transparent_bg = false,
        -- signs = {
        --   left = "",
        --   right = "",
        --   diag = "●",
        --   arrow = "    ",
        --   up_arrow = "    ",
        --   vertical = " │",
        --   vertical_end = " └",
        -- },
        options = {
          show_source = true,
          use_icons_from_diagnostic = false,
          multilines = {
            -- 启用多行诊断消息
            enabled = true,
            -- 始终在所有行上显示多行诊断信息。
            always_show = true,
          },
          virt_texts = {
            -- 优先级 - 处理与 Git Blame 的冲突
            priority = 6000,
          },
        },
      })
      -- 仅在配置中需要时，如果您已有原生LSP诊断
      vim.diagnostic.config({
        float = { border = "single" },
        virtual_text = false,
        virtual_lines = false,
        -- virtual_lines = {
        --   -- 仅显示当前光标所在行的虚拟行诊断信息
        --   current_line = true,
        -- },
      })
    end,
  },
}
