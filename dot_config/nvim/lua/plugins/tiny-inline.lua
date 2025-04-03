return {
  -- {
  --   "rachartier/tiny-glimmer.nvim",
  --   event = "TextYankPost",
  --   opts = {
  --     -- your configuration
  --   },
  -- },
  -- 同步修改 vim.diagnostic.config({ virtual_text = false })
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    enabled = true,
    config = function()
      require("tiny-inline-diagnostic").setup({
        -- "modern", "classic", "minimal", "powerline",
        -- "ghost", "simple", "nonerdfont", "amongus"
        preset = "ghost",
        transparent_bg = false,
        options = {
          show_source = true,
          use_icons_from_diagnostic = true,
          multilines = {
            -- Enable multiline diagnostic messages
            enabled = true,

            -- Always show messages on all lines for multiline diagnostics
            always_show = true,
          },
          virt_texts = {
            -- Priority for virtual text display
            priority = 3048,
          },
        },
      })
    end,
  },
}
