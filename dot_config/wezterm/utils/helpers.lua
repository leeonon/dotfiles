local wezterm = require('wezterm')
local M = {}

M.is_nvim_or_tmux = function(pane)
    local process_name = pane:get_foreground_process_name()
    if process_name == nil then
        return false
    end
    return process_name:find("nvim") or process_name:find("tmux")
end

return M
