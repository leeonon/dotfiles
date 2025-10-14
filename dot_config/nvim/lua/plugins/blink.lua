vim.g.lazyvim_blink_main = false
vim.g.lazyvim_cmp = "blink.cmp"

return {
  -- https://github.com/Saghen/blink.cmp/discussions/620
  {
    "saghen/blink.cmp",
    enabled = true,
    event = "InsertEnter",
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
          enabled = true,
          min_width = 15,
          max_height = 10,
          border = {
            { "󱐋", "WarningMsg" },
            { "─" },
            { "╮" },
            { "│" },
            { "╯" },
            { "─" },
            { "╰" },
            { "│" },
          },
          draw = {
            align_to = "cursor",
            padding = 0,
            columns = {
              -- { "item_idx" },
              { "kind_icon" },
              { "label", gap = 1 },
              { "kind", "source_name" },
            },
            components = {
              -- item_idx = {
              --   text = function(ctx)
              --     return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
              --   end,
              --   highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
              -- },
              -- 社区来源 - https://cmp.saghen.dev/configuration/sources.html#community-sources
              source_name = {
                text = function(ctx)
                  -- local name = ctx.item.client_name or ctx.item.source_name
                  local name = ctx.item.source_name
                  return "[" .. (name and name or "N/A") .. "]"
                end,
              },
              label = {
                text = function(ctx)
                  if not vim.g.rime_enabled then
                    return ctx.label .. ctx.label_detail
                  end
                  local client = vim.lsp.get_client_by_id(ctx.item.client_id)
                  if not client or client.name ~= "rime_ls" then
                    return ctx.label .. ctx.label_detail
                  end
                  local code_start = #ctx.label_detail + 1
                  for i = 1, #ctx.label_detail do
                    local ch = string.sub(ctx.label_detail, i, i)
                    if ch >= "a" and ch <= "z" then
                      code_start = i
                      break
                    end
                  end
                  local code_end = #ctx.label_detail - 4
                  local code = ctx.label_detail:sub(code_start, code_end)
                  code = string.gsub(code, "  ·  ", " ")
                  if code ~= "" then
                    code = " <" .. code .. ">"
                  end
                  return ctx.label .. code
                end,
              },
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return "" .. kind_icon .. " "
                end,
                highlight = function(ctx)
                  -- return { { group = "BlinkCmpKindIcon" .. ctx.kind, priority = 50000 } }
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        documentation = {
          draw = function(opts)
            if opts.item and opts.item.documentation and opts.item.documentation.value then
              local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
              opts.item.documentation.value = out:string()
            end

            opts.default_implementation(opts)
          end,
          window = {
            border = {
              { "", "DiagnosticHint" },
              "─",
              "╮",
              "│",
              "╯",
              "─",
              "╰",
              "│",
            },
          },
        },
      },
    },
  },
}
