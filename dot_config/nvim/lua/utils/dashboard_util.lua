local M = {}

--- Get the current Neovim version as string.
---@return string version (e.g., "v0.11.0")
function M.nvim_version()
  local v = vim.version()
  return string.format("v%d.%d.%d", v.major, v.minor, v.patch)
end

--- Get plugin loading stats.
---@return table stats Plugin stats: count, loaded, startup time, and update count.
function M.plugin_stats()
  local stats = require("lazy").stats()
  local updates = require("lazy.manage.checker").updated
  return {
    count = stats.count,
    loaded = stats.loaded,
    startuptime = (math.floor(stats.startuptime * 100 + 0.5) / 100),
    updates = #updates,
  }
end

--- Initialize dashboard and attach update hooks for plugin stats display.
---@param opts snacks.Config Configuration options for Snacks dashboard.
function M.dashboard_update(opts)
  require("snacks").setup(opts)
  vim.api.nvim_create_autocmd("User", {
    pattern = { "LazyCheck", "LazyUpdate" },
    callback = function(event)
      if event.buf == "snacks_dashboard" then
        require("snacks").dashboard.update()
      end
    end,
  })
end

--- ASCII art logos
M.logos = {
  ghost = [[
(( ))
( 0 0)    "ghost offers fragile
///> 🌸-  flower do you take?"
 v v       (y/n)]],
  -- ...
}

return M
