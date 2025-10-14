return {
  {

    "NickvanDyke/opencode.nvim",
    enabled = false,
    dependencies = {
      -- Recommended for better prompt input, and required to use `opencode.nvim`'s embedded terminal — otherwise optional
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    config = function()
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`
      }

      -- Required for `opts.auto_reload`
      vim.opt.autoread = true

      -- Recommended keymaps
      vim.keymap.set("n", "<leader>at", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })
      vim.keymap.set("n", "<leader>aA", function()
        require("opencode").ask()
      end, { desc = "Ask opencode" })
      vim.keymap.set("n", "<leader>aa", function()
        require("opencode").ask("@cursor: ")
      end, { desc = "Ask opencode about this" })
      vim.keymap.set("v", "<leader>aa", function()
        require("opencode").ask("@selection: ")
      end, { desc = "Ask opencode about selection" })
      vim.keymap.set("n", "<leader>an", function()
        require("opencode").command("session_new")
      end, { desc = "New opencode session" })
      vim.keymap.set("n", "<leader>ay", function()
        require("opencode").command("messages_copy")
      end, { desc = "Copy last opencode response" })
      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("messages_half_page_up")
      end, { desc = "Messages half page up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("messages_half_page_down")
      end, { desc = "Messages half page down" })
      vim.keymap.set({ "n", "v" }, "<leader>os", function()
        require("opencode").select()
      end, { desc = "Select opencode prompt" })

      -- Example: keymap for custom prompt
      vim.keymap.set("n", "<leader>ae", function()
        require("opencode").prompt("Explain @cursor and its context")
      end, { desc = "Explain this code" })
    end,
  },
  {
    "sudo-tee/opencode.nvim",
    enabled = false,
    config = function()
      require("opencode").setup({
        preferred_picker = nil, -- 'telescope', 'fzf', 'mini.pick', 'snacks'，如果为nil，将使用最佳可用选择器
        preferred_completion = nil, -- 'blink', 'nvim-cmp','vim_complete'，如果为nil，将使用最佳可用补全
        default_global_keymaps = true, -- 如果为false，则禁用所有默认全局键位映射
        default_mode = "build", -- 'build' 或 'plan' 或任何自定义配置的模式。@参见 [OpenCode 代理](https://opencode.ai/docs/modes/)
        config_file_path = nil, -- opencode配置文件路径，如果不同于默认的 `~/.config/opencode/config.json` 或 `~/.config/opencode/opencode.json`
        keymap_prefix = "<leader>o",
        keymap = {
          editor = {
            ["<leader>og"] = { "toggle" }, -- Open opencode. Close if opened
            ["<leader>oi"] = { "open_input" }, -- Opens and focuses on input window on insert mode
            ["<leader>oI"] = { "open_input_new_session" }, -- Opens and focuses on input window on insert mode. Creates a new session
            ["<leader>oo"] = { "open_output" }, -- Opens and focuses on output window
            ["<leader>ot"] = { "toggle_focus" }, -- Toggle focus between opencode and last window
            ["<leader>oq"] = { "close" }, -- Close UI windows
            ["<leader>os"] = { "select_session" }, -- Select and load a opencode session
            ["<leader>op"] = { "configure_provider" }, -- Quick provider and model switch from predefined list
            ["<leader>od"] = { "diff_open" }, -- Opens a diff tab of a modified file since the last opencode prompt
            ["<leader>o]"] = { "diff_next" }, -- Navigate to next file diff
            ["<leader>o["] = { "diff_prev" }, -- Navigate to previous file diff
            ["<leader>oc"] = { "diff_close" }, -- Close diff view tab and return to normal editing
            ["<leader>ora"] = { "diff_revert_all_last_prompt" }, -- Revert all file changes since the last opencode prompt
            ["<leader>ort"] = { "diff_revert_this_last_prompt" }, -- Revert current file changes since the last opencode prompt
            ["<leader>orA"] = { "diff_revert_all" }, -- Revert all file changes since the last opencode session
            ["<leader>orT"] = { "diff_revert_this" }, -- Revert current file changes since the last opencode session
            ["<leader>orr"] = { "diff_restore_snapshot_file" }, -- Restore a file to a restore point
            ["<leader>orR"] = { "diff_restore_snapshot_all" }, -- Restore all files to a restore point
            ["<leader>ox"] = { "swap_position" }, -- Swap Opencode pane left/right
            ["<leader>opa"] = { "permission_accept" }, -- Accept permission request once
            ["<leader>opA"] = { "permission_accept_all" }, -- Accept all (for current tool)
            ["<leader>opd"] = { "permission_deny" }, -- Deny permission request once
          },
          input_window = {
            ["<cr>"] = { "submit_input_prompt", mode = { "n", "i" } }, -- Submit prompt (normal mode and insert mode)
            ["<esc>"] = { "close" }, -- Close UI windows
            ["<C-c>"] = { "stop" }, -- Stop opencode while it is running
            ["~"] = { "mention_file", mode = "i" }, -- Pick a file and add to context. See File Mentions section
            ["@"] = { "mention", mode = "i" }, -- Insert mention (file/agent)
            ["/"] = { "slash_commands", mode = "i" }, -- Pick a command to run in the input window
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle between input and output panes
            ["<up>"] = { "prev_prompt_history", mode = { "n", "i" } }, -- Navigate to previous prompt in history
            ["<down>"] = { "next_prompt_history", mode = { "n", "i" } }, -- Navigate to next prompt in history
            ["<M-m>"] = { "switch_mode" }, -- Switch between modes (build/plan)
          },
          output_window = {
            ["<esc>"] = { "close" }, -- Close UI windows
            ["<C-c>"] = { "stop" }, -- Stop opencode while it is running
            ["]]"] = { "next_message" }, -- Navigate to next message in the conversation
            ["[["] = { "prev_message" }, -- Navigate to previous message in the conversation
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle between input and output panes
            ["<C-i>"] = { "focus_input" }, -- Focus on input window and enter insert mode at the end of the input from the output window
            ["<leader>oS"] = { "select_child_session" }, -- Select and load a child session
            ["<leader>oD"] = { "debug_message" }, -- Open raw message in new buffer for debugging
            ["<leader>oO"] = { "debug_output" }, -- Open raw output in new buffer for debugging
            ["<leader>ods"] = { "debug_session" }, -- Open raw session in new buffer for debugging
          },
          permission = {
            accept = "a", -- Accept permission request once (only available when there is a pending permission request)
            accept_all = "A", -- Accept all (for current tool) permission request once (only available when there is a pending permission request)
            deny = "d", -- Deny permission request once (only available when there is a pending permission request)
          },
        },
        ui = {
          position = "right", -- 'right'（默认）或 'left'。UI分割的位置
          input_position = "bottom", -- 'bottom'（默认）或 'top'。输入窗口的位置
          window_width = 0.40, -- 窗口宽度占编辑器宽度的百分比
          input_height = 0.15, -- 输入窗口高度占窗口高度的百分比
          display_model = true, -- 在顶部窗口栏显示模型名称
          display_context_size = true, -- 在页脚显示上下文大小
          display_cost = true, -- 在页脚显示成本
          window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder", -- opencode窗口的高亮组
          icons = {
            preset = "emoji", -- 'emoji' | 'text'。选择UI图标样式（默认：'emoji'）
            overrides = {}, -- 可选的按键覆盖，参见下方章节
          },
          output = {
            tools = {
              show_output = true, -- 显示工具输出[差异，命令输出等]（默认：true）
            },
          },
          input = {
            text = {
              wrap = false, -- 在输入窗口内自动换行
            },
          },
          completion = {
            file_sources = {
              enabled = true,
              preferred_cli_tool = "fd", -- 'fd','fdfind','rg','git'，如果为nil，将使用最佳可用工具
              ignore_patterns = {
                "^%.git/",
                "^%.svn/",
                "^%.hg/",
                "node_modules/",
                "%.pyc$",
                "%.o$",
                "%.obj$",
                "%.exe$",
                "%.dll$",
                "%.so$",
                "%.dylib$",
                "%.class$",
                "%.jar$",
                "%.war$",
                "%.ear$",
                "target/",
                "build/",
                "dist/",
                "out/",
                "deps/",
                "%.tmp$",
                "%.temp$",
                "%.log$",
                "%.cache$",
              },
              max_files = 10,
              max_display_length = 50, -- 补全中文件路径显示的最大长度，从左侧用"..."截断
            },
          },
        },
        context = {
          enabled = true, -- 启用自动上下文捕获
          cursor_data = {
            enabled = false, -- 在上下文中包含光标位置和行内容
          },
          diagnostics = {
            info = false, -- 在上下文中包含诊断信息（默认为false）
            warn = true, -- 在上下文中包含诊断警告
            error = true, -- 在上下文中包含诊断错误
          },
          current_file = {
            enabled = true, -- 在上下文中包含当前文件路径和内容
          },
          selection = {
            enabled = true, -- 在上下文中包含选中的文本
          },
        },
        debug = {
          enabled = false, -- 在输出窗口中启用调试消息
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
      },
      "saghen/blink.cmp",
      "folke/snacks.nvim",
    },
  },
}
