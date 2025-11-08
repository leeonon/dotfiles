vim.g.lazyvim_blink_main = false
vim.g.lazyvim_cmp = "blink.cmp"

return {
  -- https://github.com/Saghen/blink.cmp/discussions/620
  {
    "saghen/blink.cmp",
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "Kaiser-Yang/blink-cmp-dictionary" },
      "L3MON4D3/LuaSnip",
      "xieyonn/blink-cmp-dat-word", -- 单词补全源
    },
    opts = {
      keymap = {
        -- ["<Tab>"] = {
        --   "snippet_forward",
        --   function() -- sidekick next edit suggestion
        --     return require("sidekick").nes_jump_or_apply()
        --   end,
        --   function() -- if you are using Neovim's native inline completions
        --     return vim.lsp.inline_completion.get()
        --   end,
        --   "fallback",
        -- },
        ["<C-y>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        -- ["<C-y>"] = { "select_and_accept" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-U>"] = { "scroll_documentation_up", "fallback" },
        ["<C-D>"] = { "scroll_documentation_down", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "buffer", "path", "dictionary" },
        providers = {
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            opts = {},
          },
          -- avante = { name = "Avante", module = "blink-cmp-avante" },
        },
      },
      -- 实现性的签名支持
      signature = { enabled = true },
      completion = {
        accept = {
          dot_repeat = false,
          -- 自动括号
          auto_brackets = {
            enabled = false,
          },
        },
        -- TODO: 幽灵文本
        ghost_text = {
          enabled = false,
          -- show_with_menu = false,
        },
        list = {
          -- 预选、自动插入
          selection = { preselect = true, auto_insert = false },
        },
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
        menu = {
          -- border = {
          --   { "󱐋", "WarningMsg" },
          --   { "─" },
          --   { "╮" },
          --   { "│" },
          --   { "╯" },
          --   { "─" },
          --   { "╰" },
          --   { "│" },
          -- },
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          -- draw = function(opts)
          --   if opts.item and opts.item.documentation and opts.item.documentation.value then
          --     local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
          --     opts.item.documentation.value = out:string()
          --   end
          --
          --   opts.default_implementation(opts)
          -- end,
          -- window = {
          --   border = {
          --     { "", "DiagnosticHint" },
          --     "─",
          --     "╮",
          --     "│",
          --     "╯",
          --     "─",
          --     "╰",
          --     "│",
          --   },
          -- },
        },
      },
    },
  },
}
