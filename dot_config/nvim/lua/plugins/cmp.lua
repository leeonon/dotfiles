local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_kinds = {
  Text = "  ",
  Method = "  ",
  Function = "  ",
  Constructor = "  ",
  Field = "  ",
  Variable = "  ",
  Class = "  ",
  Interface = "  ",
  Module = "  ",
  Property = "  ",
  Unit = "  ",
  Value = "  ",
  Enum = "  ",
  Keyword = "  ",
  Snippet = "  ",
  Color = "  ",
  File = "  ",
  Reference = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "  ",
  Struct = "  ",
  Event = "  ",
  Operator = "  ",
  TypeParameter = "  ",
}

local function mapping(is_cmdline)
  if is_cmdline == nil then
    is_cmdline = false
  end
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  return {
    ["<C-N>"] = cmp.mapping(function()
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end, { "i", "c" }),
    ["<C-P>"] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "c" }),
    ["<C-K>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "c" }),
    ["<C-J>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        cmp.complete()
      end
    end, { "i", "c" }),
    -- https://github.com/zbirenbaum/copilot.lua/issues/91
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      elseif cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "onsails/lspkind.nvim",
      -- 在CSS文件中输入要转换为 css 代码的 tailwindcss 类，自动转为CSS
      "jcha0713/cmp-tw2css",
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, { name = "tmux" })
      table.insert(opts.sources, { name = "cmp-tw2css" })
      opts.mapping = vim.tbl_extend("force", opts.mapping, mapping())

      opts.completion = {
        -- 自动选中第一条
        completeopt = "menu,menuone,preview,noinsert",
      }

      opts.window = {
        completion = {
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
          col_offset = -3,
          side_padding = 0,
          scrollbar = false,
          winblend = 0,
        },

        documentation = {
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
          side_padding = 0,
          scrollbar = false,
          winblend = 0,
        },
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"

          return kind
        end,
      }

      -- onsails/lspkind.nvim 图标
      -- opts.formatting = {
      --   format = lspkind.cmp_format(),
      -- }

      -- VSCode 风格图标，需要 vscode codicon 字体
      -- opts.formatting = {
      --   format = function(_, vim_item)
      --     vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
      --     return vim_item
      --   end,
      -- }

      -- Lazyvim config
      -- opts.formatting = {
      --   format = function(entry, item)
      --     local icons = LazyVim.config.icons.kinds
      --     if icons[item.kind] then
      --       item.kind = icons[item.kind] .. item.kind
      --     end
      --
      --     local widths = {
      --       abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
      --       menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
      --     }
      --
      --     for key, width in pairs(widths) do
      --       if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
      --         item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
      --       end
      --     end
      --
      --     return item
      --   end,
      -- }
    end,
  },
}
