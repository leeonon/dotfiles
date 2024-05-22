-- change some telescope options and a keymap to browse plugin files
-- 如果报 fzf 扩展未安装的错误
-- 进入到 telescope-fzf-native 安装目录 - ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
-- 执行 make 命令
-- 参考:https://github.com/AstroNvim/AstroNvim/issues/58
return {
  "telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    {
      "<leader>fP",
      function()
        require("telescope.builtin").find_files({
          cwd = require("lazy.core.config").options.root,
        })
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>;f",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          hidden = true,
        })
      end,
      desc = "列出当前工作目录中的文件，遵守 .gitignore 文件。",
    },
    {
      "<leader>;r",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep()
      end,
      desc = "在您当前的工作目录中搜索字符串，并在您输入时实时获取结果，遵守.gitignore文件。",
    },
    {
      "\\\\",
      function()
        local builtin = require("telescope.builtin")
        builtin.buffers()
      end,
      desc = "列出打开的缓冲区",
    },
    {
      "<leader>;t",
      function()
        local builtin = require("telescope.builtin")
        builtin.help_tags()
      end,
      desc = "列出可用的帮助标签，并在按下<cr>时打开一个新窗口，显示相关的帮助信息。",
    },
    {
      "<leader>;;",
      function()
        local builtin = require("telescope.builtin")
        builtin.resume()
      end,
      desc = "恢复之前的望远镜选择器",
    },
    {
      "<leader>;e",
      function()
        local builtin = require("telescope.builtin")
        builtin.diagnostics()
      end,
      desc = "列出所有打开的缓冲区或特定缓冲区的诊断信息。",
    },
    {
      "<leader>;s",
      function()
        local builtin = require("telescope.builtin")
        builtin.treesitter()
      end,
      desc = "列出函数名称、变量，来自Treesitter",
    },
    {
      "sf",
      function()
        local telescope = require("telescope")

        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end,
      desc = "使用当前缓冲区的路径打开文件浏览器",
    },
    {
      "<leader>;gb",
      function()
        local builtin = require("telescope.builtin")
        builtin.git_branches()
      end,
      desc = "列出所有的Git分支",
    },
    {
      "<leader>;gc",
      function()
        local builtin = require("telescope.builtin")
        builtin.git_bcommits_range()
      end,
      desc = "列出当前缓冲区的 Git 提交",
    },
    {
      "<leader>;gs",
      function()
        local builtin = require("telescope.builtin")
        builtin.git_status()
      end,
      desc = "列出Git状态中的所有文件",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      wrap_results = true,
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        n = {},
      },
    })
    opts.pickers = {
      diagnostics = {
        theme = "ivy",
        initial_mode = "normal",
        layout_config = {
          preview_cutoff = 9999,
        },
      },
    }
    opts.extensions = {
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          -- your custom insert mode mappings
          ["n"] = {
            -- your custom normal mode mappings
            ["N"] = fb_actions.create,
            ["h"] = fb_actions.goto_parent_dir,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
            ["<C-u>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_previous(prompt_bufnr)
              end
            end,
            ["<C-d>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_next(prompt_bufnr)
              end
            end,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
          },
        },
      },
    }
    telescope.setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}

