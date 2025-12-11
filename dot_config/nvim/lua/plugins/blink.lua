vim.g.lazyvim_blink_main = false
vim.g.lazyvim_cmp = "blink.cmp"

local function get_lsp_completion_context(completion)
  local ok, source_name = pcall(function()
    return vim.lsp.get_client_by_id(completion.client_id).name
  end)
  if not ok then
    return nil
  end

  if source_name == "ts_ls" then
    return completion.detail
  elseif source_name == "pyright" and completion.labelDetails ~= nil then
    return completion.labelDetails.description
  elseif source_name == "texlab" then
    return completion.detail
  elseif source_name == "clangd" then
    local doc = completion.documentation
    if doc == nil then
      return
    end

    local import_str = doc.value
    import_str = import_str:gsub("[\n]+", "")

    local str
    str = import_str:match("<(.-)>")
    if str then
      return "<" .. str .. ">"
    end

    str = import_str:match("[\"'](.-)[\"']")
    if str then
      return '"' .. str .. '"'
    end

    return nil
  end
end

return {
  -- https://github.com/Saghen/blink.cmp/discussions/620
  {
    "saghen/blink.cmp",
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "xieyonn/blink-cmp-dat-word", -- 单词补全源
    },
    opts = {
      keymap = {
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
        default = { "lsp", "buffer", "path" },
      },
      signature = { enabled = true },
      completion = {
        accept = {
          dot_repeat = false,
          -- 自动括号
          auto_brackets = {
            enabled = false,
          },
        },
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
            treesitter = { "lsp" },
            components = {
              label_description = {
                text = function(ctx)
                  return get_lsp_completion_context(ctx.item)
                end,
                highlight = "BlinkCmpLabelDescription",
              },
            },
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
