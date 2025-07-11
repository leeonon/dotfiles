local git_status_cache = {}

local colors = {
  bg = "#161617",
  fg = "#c9c7cd",
  subtext1 = "#b4b1ba",
  subtext2 = "#9f9ca6",
  subtext3 = "#8b8693",
  subtext4 = "#6c6874",
  bg_dark = "#131314",
  black = "#27272a",
  red = "#ea83a5",
  green = "#90b99f",
  yellow = "#e6b99d",
  purple = "#aca1cf",
  magenta = "#e29eca",
  orange = "#f5a191",
  blue = "#92a2d5",
  cyan = "#85b5ba",
  gray0 = "#18181a",
  gray1 = "#1b1b1c",
  gray2 = "#2a2a2c",
  gray3 = "#313134",
  gray4 = "#3b3b3e",
  gray5 = "#444448",
  none = "NONE",
}

local on_exit_fetch = function(result)
  if result.code == 0 then
    git_status_cache.fetch_success = true
  end
end

local function handle_numeric_result(cache_key)
  return function(result)
    if result.code == 0 then
      git_status_cache[cache_key] = tonumber(result.stdout:match("(%d+)")) or 0
    end
  end
end

local async_cmd = function(cmd_str, on_exit)
  local cmd = vim.tbl_filter(function(element)
    return element ~= ""
  end, vim.split(cmd_str, " "))

  vim.system(cmd, { text = true }, on_exit)
end

local async_git_status_update = function()
  -- Fetch the latest changes from the remote repository (replace 'origin' if needed)
  async_cmd("git fetch origin", on_exit_fetch)
  if not git_status_cache.fetch_success then
    return
  end

  -- Get the number of commits behind
  -- the @{upstream} notation is inspired by post: https://www.reddit.com/r/neovim/comments/t48x5i/git_branch_aheadbehind_info_status_line_component/
  -- note that here we should use double dots instead of triple dots
  local behind_cmd_str = "git rev-list --count HEAD..@{upstream}"
  async_cmd(behind_cmd_str, handle_numeric_result("behind_count"))

  -- Get the number of commits ahead
  local ahead_cmd_str = "git rev-list --count @{upstream}..HEAD"
  async_cmd(ahead_cmd_str, handle_numeric_result("ahead_count"))
end

local function get_ahead_behind_info()
  local status = git_status_cache

  if not status then
    return ""
  end

  local msg = ""

  if type(status.ahead_count) == "number" and status.ahead_count > 0 then
    local ahead_str = string.format("↑[%d] ", status.ahead_count)
    msg = msg .. ahead_str
  end

  if type(status.behind_count) == "number" and status.behind_count > 0 then
    local behind_str = string.format("↓[%d] ", status.behind_count)
    msg = msg .. behind_str
  end

  return msg
end

local timer = vim.uv.new_timer()
if timer then
  timer:start(0, 1000, async_git_status_update)
else
  vim.notify("Failed to create timer", vim.log.levels.WARN)
end

local function get_lualine_colors()
  local colorname = vim.g.colors_name:gsub("^four%-symbols%-", "") or "black-tortoise"
  local name = vim.g.colors_name:match("^four%-symbols%-") and colorname or "black-tortoise"
  local c = require("four-symbols.palette").get_palette(name)
  return c
end

local function getLspName()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
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
  --
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

local icons = require("lazyvim.config").icons
return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "bwpge/lualine-pretty-path",
  },
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
    -- local colors = get_lualine_colors()
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus
    local space = {
      function()
        return " "
      end,
      color = { bg = nil, fg = nil },
    }

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
      t = colors.red,
    }

    local theme = {
      normal = {
        a = { fg = colors.bg_dark, bg = nil },
        b = { fg = colors.blue, bg = nil },
        c = { fg = colors.white, bg = nil },
        z = { fg = colors.white, bg = nil },
      },
      insert = { a = { fg = colors.bg_dark, bg = nil } },
      visual = { a = { fg = colors.bg_dark, bg = nil } },
      replace = { a = { fg = colors.bg_dark, bg = nil } },
    }

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
        lualine_a = {
          {
            function()
              -- 󰂵           󰝨 󰙴  󰊠 󱙝  
              return "󱙝"
            end,
            color = function()
              local mode_color = modecolor
              return { bg = nil, fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
            padding = { right = 0, left = 1 },
          },
          {
            "mode",
            color = function()
              local mode_color = modecolor
              return { bg = nil, fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
            -- separator = { left = "", right = "" },
            separator = { left = "", right = "" },
          },
          -- filesize,
        },
        lualine_b = {},
        lualine_c = {
          {
            "pretty_path",
            icon_show = true,
            highlights = {
              modified = { fg = "#ff00ff", bold = true, italic = true },
              path_sep = "Comment",
            },
            icon_padding = {
              [""] = 0, -- disable extra padding for terminal icon
            },
            -- "filename",
            path = 5,
            padding = 1,
            color = { fg = colors.fg_01 },
            -- separator = { left = "", right = "" },
          },
          {
            "branch",
            icon = "",
            color = { bg = nil, fg = colors.green, gui = "bold" },
            -- separator = { left = "", right = "" },
            -- separator = { left = "", right = "" },
          },
          {
            get_ahead_behind_info,
            color = { fg = colors.cyan },
          },
          {
            "diff",
            -- color = { bg = colors.gray2, fg = colorsbg_01, gui = "bold" },
            color = { bg = nil, fg = colors.orange, gui = "bold" },
            -- separator = { left = "", right = "" },
            -- separator = { left = "", right = "" },
            symbols = { added = " ", modified = " ", removed = " " },

            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
          },
          -- {
          --   "location",
          --   color = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
          --   separator = { left = "", right = "" },
          --   -- separator = { left = "", right = "" },
          -- },
        },
        lualine_x = {
          space,
          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = { fg = Snacks.util.color("Constant") },
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = { fg = Snacks.util.color("Debug") }
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = Snacks.util.color("Special") },
          },
        },
        lualine_y = {
          { "lsp_progress" },
        },
        lualine_z = {
          {
            function()
              return require("plugins.codecompanion.utils.companion_lualine.lua")
            end,
            color = { bg = nil },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.purple },
              hint = { fg = colors.cyan },
            },
            color = { bg = nil, fg = colors.orange, gui = "bold" },
            -- color = { bg = nil, fg = colors.blue },
            -- separator = { left = "" },
            separator = { left = "", right = "" },
          },
          {
            function()
              return getLspName()
            end,
            -- separator = { left = "", right = "" },
            separator = { left = "", right = "" },
            color = { bg = nil, fg = colors.purple, gui = "italic,bold" },
          },
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
