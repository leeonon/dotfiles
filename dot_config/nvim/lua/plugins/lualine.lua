local colors = require("oldworld.palette")

local modecolor = {
    n = colors.red,
    i = colors.cyan,
    v = colors.purple,
    [""] = colors.purple,
    V = colors.red,
    c = colors.yellow,
    no = colors.red,
    s = colors.yellow,
    S = colors.yellow,
    [""] = colors.yellow,
    ic = colors.yellow,
    R = colors.green,
    Rv = colors.purple,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
    t = colors.bright_red,
}

local theme = {
    normal = {
        a = { fg = colors.bg_dark, bg = colors.blue },
        b = { fg = colors.blue, bg = colors.white },
        c = { fg = colors.white, bg = colors.bg_dark },
        z = { fg = colors.white, bg = colors.bg_dark },
    },
    insert = { a = { fg = colors.bg_dark, bg = colors.orange } },
    visual = { a = { fg = colors.bg_dark, bg = colors.green } },
    replace = { a = { fg = colors.bg_dark, bg = colors.green } },
}

local space = {
    function()
        return " "
    end,
    color = { bg = colors.bg_dark, fg = colors.blue },
}

local filename = {
    "filename",
    color = { bg = colors.blue, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local filetype = {
    "filetype",
    icons_enabled = false,
    color = { bg = colors.gray2, fg = colors.blue, gui = "italic,bold" },
    separator = { left = "", right = "" },
}

local branch = {
    "branch",
    icon = "",
    color = { bg = colors.green, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local location = {
    "location",
    color = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local diff = {
    "diff",
    color = { bg = colors.gray2, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
    symbols = { added = " ", modified = " ", removed = " " },

    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
}

local modes = {
    "mode",
    color = function()
        local mode_color = modecolor
        return { bg = mode_color[vim.fn.mode()], fg = colors.bg_dark, gui = "bold" }
    end,
    separator = { left = "", right = "" },
}

local function getLspName()
    local buf_clients = vim.lsp.buf_get_clients()
    local buf_ft = vim.bo.filetype
    if next(buf_clients) == nil then
        return "  No servers"
    end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    local lint_s, lint = pcall(require, "lint")
    if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
            if type(ft_v) == "table" then
                for _, linter in ipairs(ft_v) do
                    if buf_ft == ft_k then
                        table.insert(buf_client_names, linter)
                    end
                end
            elseif type(ft_v) == "string" then
                if buf_ft == ft_k then
                    table.insert(buf_client_names, ft_v)
                end
            end
        end
    end

    local ok, conform = pcall(require, "conform")
    local formatters = table.concat(conform.list_formatters_for_buffer(), " ")
    if ok then
        for formatter in formatters:gmatch("%w+") do
            if formatter then
                table.insert(buf_client_names, formatter)
            end
        end
    end

    local hash = {}
    local unique_client_names = {}

    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
        end
    end
    local language_servers = table.concat(unique_client_names, ", ")

    return "  " .. language_servers
end

local macro = {
    require("noice").api.status.mode.get,
    cond = require("noice").api.status.mode.has,
    color = { fg = colors.red, bg = colors.bg_dark, gui = "italic,bold" },
}

local dia = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.purple },
        hint = { fg = colors.cyan },
    },
    color = { bg = colors.gray2, fg = colors.blue, gui = "bold" },
    separator = { left = "" },
}

local lsp = {
    function()
        return getLspName()
    end,
    separator = { left = "", right = "" },
    color = { bg = colors.purple, fg = colors.bg, gui = "italic,bold" },
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require
  
    local icons = require("lazyvim.config").icons
  
    vim.o.laststatus = vim.g.lualine_laststatus
  
    return {
      options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { modes },
        lualine_b = { space },
        lualine_c = {
          -- lazyvim normal
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
          --
          filename,
          filetype,
          space,
          branch,
          diff,
          space,
          location,
        },
        lualine_x = {
          space,
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = LazyVim.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = LazyVim.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = LazyVim.ui.fg("Debug"),
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = LazyVim.ui.fg("Special"),
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
          macro, space
        },
        lualine_z = {
          -- function()
          --   return " " .. os.date("%R")
          -- end,
          dia,
          lsp,
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end
}
