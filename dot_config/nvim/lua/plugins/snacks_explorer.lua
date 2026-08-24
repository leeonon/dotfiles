-- https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md
return {
    desc = "Snacks File Explorer",
    recommended = true,
    "folke/snacks.nvim",
    opts = {
        explorer = {
            replace_netrw = true, -- 用 snacks explorer 替换 netrw
            trash = true, -- 删除文件时使用系统废纸篓
        },
        -- picker source 级配置（snacks.picker.explorer.Config）
        picker = {
            sources = {
                explorer = {
                    -- 查找器
                    finder = "explorer",
                    sort = { fields = { "sort" } },
                    supports_live = true,

                    -- explorer 专属
                    follow_file = false, -- 打开时不自动跟随当前文件
                    tree = true, -- 显示文件树
                    git_status = true, -- 显示 git 状态
                    git_status_open = false, -- 为展开的目录递归显示 git 状态
                    git_untracked = true, -- 显示未跟踪的 git 状态所需
                    diagnostics = true, -- 显示诊断
                    diagnostics_open = false, -- 为展开的目录递归显示诊断
                    watch = true, -- 监听文件变化
                    exclude = {}, -- 排除的 glob 模式
                    hidden = false,
                    include = {
                        ".env*",
                    }, -- 包含的 glob 模式（优先级高于 exclude/ignored/hidden）

                    -- 界面
                    focus = "list",
                    auto_close = false,
                    jump = { close = false },
                    layout = {
                        preset = "sidebar",
                        backdrop = true,
                        preview = false,
                        border = "none",
                    },

                    -- 匹配 / 格式化
                    matcher = { sort_empty = false, fuzzy = false },
                    formatters = {
                        file = { filename_only = true },
                        severity = { pos = "right" },
                    },
                    -- 移除缩进线线，但保留缩进
                    icons = {
                        tree = {
                            vertical = "  ",
                            middle = "  ",
                            last = "  ",
                        },
                    },
                    on_show = function(picker)
                        local show = false
                        local gap = 1
                        local clamp_width = function(value)
                            return math.max(20, math.min(100, value))
                        end
                        --
                        local position = picker.resolved_layout.layout.position
                        local rel = picker.layout.root
                        local update = function(win) ---@param win snacks.win
                            local border = win:border_size().left + win:border_size().right
                            win.opts.row = vim.api.nvim_win_get_position(rel.win)[1]
                            win.opts.height = 0.8
                            if position == "left" then
                                win.opts.col = vim.api.nvim_win_get_width(rel.win) + gap
                                win.opts.width = clamp_width(vim.o.columns - border - win.opts.col)
                            end
                            if position == "right" then
                                win.opts.col = -vim.api.nvim_win_get_width(rel.win) - gap
                                win.opts.width = clamp_width(vim.o.columns - border + win.opts.col)
                            end
                            win:update()
                        end
                        local preview_win = Snacks.win.new({
                            relative = "editor",
                            external = false,
                            focusable = false,
                            border = "rounded",
                            backdrop = false,
                            show = show,
                            bo = {
                                filetype = "snacks_float_preview",
                                buftype = "nofile",
                                buflisted = false,
                                swapfile = false,
                                undofile = false,
                            },
                            on_win = function(win)
                                update(win)
                                picker:show_preview()
                            end,
                        })
                        rel:on("WinLeave", function()
                            vim.schedule(function()
                                if not picker:is_focused() then
                                    picker.preview.win:close()
                                end
                            end)
                        end)
                        rel:on("WinResized", function()
                            update(preview_win)
                        end)
                        picker.preview.win = preview_win
                        picker.main = preview_win.win
                    end,
                    on_close = function(picker)
                        picker.preview.win:close()
                    end,
                    actions = {
                        -- `<A-p>`
                        toggle_preview = function(picker) --[[Override]]
                            picker.preview.win:toggle()
                        end,
                    },
                },
            },
        },
    },
    keys = {
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "Explorer Snacks (cwd)",
        },
        {
            "<leader>E",
            function()
                Snacks.explorer.reveal()
            end,
            desc = "Explorer Reveal File",
        },
    },
}
