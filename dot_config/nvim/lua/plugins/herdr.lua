-- lazy `keys` registers a handler so LazyVim.safe_keymap_set skips its
-- <C-w>h/j/k/l maps. dofile() in config() is too early and gets overwritten.
local function nav(wincmd, dir)
    local prev = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. wincmd)
    if vim.api.nvim_get_current_win() ~= prev then
        return
    end
    if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
        local herdr = vim.env.HERDR_BIN_PATH
        if herdr == nil or herdr == "" then
            herdr = "herdr"
        end
        vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--pane", vim.env.HERDR_PANE_ID })
    elseif vim.env.TMUX and vim.env.TMUX ~= "" then
        local tmux = { left = "Left", down = "Down", up = "Up", right = "Right" }
        pcall(vim.cmd, "TmuxNavigate" .. tmux[dir])
    end
end

return {
    {
        "christoomey/vim-tmux-navigator",
        init = function()
            vim.g.tmux_navigator_no_mappings = 1
        end,
    },
    {
        "paulbkim-dev/vim-herdr-navigation",
        dependencies = { "christoomey/vim-tmux-navigator" },
        keys = {
            {
                "<C-h>",
                function()
                    nav("h", "left")
                end,
                desc = "Navigate left (vim/herdr)",
            },
            {
                "<C-j>",
                function()
                    nav("j", "down")
                end,
                desc = "Navigate down (vim/herdr)",
            },
            {
                "<C-k>",
                function()
                    nav("k", "up")
                end,
                desc = "Navigate up (vim/herdr)",
            },
            {
                "<C-l>",
                function()
                    nav("l", "right")
                end,
                desc = "Navigate right (vim/herdr)",
            },
        },
    },
}
