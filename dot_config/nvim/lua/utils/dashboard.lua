local util = require("utils.dashboard_util")

local keys = {
  { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
  { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
  { icon = " ", key = "s", desc = "Restore Session", section = "session" },
  { icon = " ", key = "n", desc = "Touch", action = ":enew" },
  { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
  { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
  { icon = "󰩈 ", key = "q", desc = "Leave", action = ":qa" },
}

local function status_section()
  local version = util.nvim_version()
  local stats = util.plugin_stats()
  local date = os.date("%d.%m.%Y")
  return {
    align = "center",
    text = {
      { "  ", hl = "special" },
      { version, hl = "NonText" },
      { "     ", hl = "footer" },
      { string.format("%d (%s ms)", stats.count or 0, stats.startuptime or "?"), hl = "NonText" },
      { "     ", hl = "footer" },
      { date, hl = "NonText" },
    },
  }
end

local dashboard_config = {
  enabled = true,
  width = 30,
  preset = {
    header = util.logos.ghost,
    keys = keys,
  },
  formats = {
    header = { "%s", align = "left" },
  },
  sections = {
    { section = "header" },
    { section = "keys", padding = 2 },
    {
      align = "center",
      padding = 2,
      text = { "⌜ ᓚᘏᗢ des ⌟\na cat is fine too...", hl = "NonText" },
    },
    status_section,
  },
}

return dashboard_config
