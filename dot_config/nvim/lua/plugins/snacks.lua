return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = {
      enabled = true,
    },
    terminal = {
      win = {
        -- position = "bottom",
      },
    },
    -- https://github.com/folke/snacks.nvim/discussions/111
    dashboard = {
      enabled = true,
      preset = {
        header = [[
████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████]],
      },
      formats = {
        key = function(item)
          return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
        end,
      },
      sections = {
        {
          section = "header",
          padding = 4,
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    indent = {
      enabled = false,
    },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    input = {
      enabled = true,
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },
    picker = {
      -- !NOTE: picker keymaps : https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
      -- prompt = "➡️ ",
      prompt = "[SNACKS] 🍪 ",
      focus = "input", -- "input" | "list" ,
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
          -- "vscode" | "default" | "sidebar" | "vertical" | "select"  | "right" | "left" | ivy_split | ivy | dropdown
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
      },
    },
    scratch = {
      enabled = false,
    },
    zen = {
      toggles = {
        dim = true,
        git_signs = true,
        mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
      },
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      },
      zoom = {
        toggles = {},
        show = { statusline = false, tabline = false },
        win = {
          backdrop = false,
          width = 0, -- full width
        },
      },
    },
  },
  -- lazy snacls picker 默认快捷键 - https://www.lazyvim.org/extras/editor/snacks_picker
  keys = {
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>.",
      nil,
    },
    {
      "<leader>S",
      nil,
    },
  },
  init = function()
    vim.b.miniindentscope_disable = true

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        -- Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
