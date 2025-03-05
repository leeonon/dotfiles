return {
  -- https://github.com/Saghen/blink.cmp/discussions/620
  {
    "saghen/blink.cmp",
    enabled = true,
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    opts = {
      keymap = {
        ["<C-y>"] = { "select_and_accept" },
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
        ["<A-1>"] = {
          function(cmp)
            cmp.accept({ index = 1 })
          end,
        },
        ["<A-2>"] = {
          function(cmp)
            cmp.accept({ index = 2 })
          end,
        },
        ["<A-3>"] = {
          function(cmp)
            cmp.accept({ index = 3 })
          end,
        },
        ["<A-4>"] = {
          function(cmp)
            cmp.accept({ index = 4 })
          end,
        },
        ["<A-5>"] = {
          function(cmp)
            cmp.accept({ index = 5 })
          end,
        },
        ["<A-6>"] = {
          function(cmp)
            cmp.accept({ index = 6 })
          end,
        },
        ["<A-7>"] = {
          function(cmp)
            cmp.accept({ index = 7 })
          end,
        },
        ["<A-8>"] = {
          function(cmp)
            cmp.accept({ index = 8 })
          end,
        },
        ["<A-9>"] = {
          function(cmp)
            cmp.accept({ index = 9 })
          end,
        },
        ["<A-0>"] = {
          function(cmp)
            cmp.accept({ index = 10 })
          end,
        },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "buffer", "snippets", "path", "avante" },
        providers = {
          avante = { name = "Avante", module = "blink-cmp-avante" },
        },
      },
      completion = {
        accept = {
          -- 自动括号
          auto_brackets = {
            enabled = true,
          },
        },
        -- 幽灵文本
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
              { "item_idx" },
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
            components = {
              -- 定义建议的index，可通过快捷键 A ~ index 来选择
              item_idx = {
                text = function(ctx)
                  return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
                end,
                highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
              },
              source_name = {
                text = function(ctx)
                  return "[" .. ctx.source_name .. "]"
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
            },
          },
        },
        documentation = {
          window = {
            border = {
              { "󰙎", "DiagnosticHint" },
              { "─" },
              { "╮" },
              { "│" },
              { "╯" },
              { "─" },
              { "╰" },
              { "│" },
            },
          },
        },
      },
    },
  },
}
