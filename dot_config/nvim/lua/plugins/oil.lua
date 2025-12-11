function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = {
      { "nvim-mini/mini.icons", opts = {} },
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      local detail = false
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        keymaps = {
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
              else
                require("oil").set_columns({ "icon" })
              end
            end,
          },
          ["cc"] = {
            desc = "Copy filepath to system clipboard",
            callback = function()
              require("oil.actions").copy_entry_path.callback()
              vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
              vim.notify("Copied full path", "info", { title = "Oil" })
            end,
          },
        },
        win_options = {
          winbar = "%!v:lua.get_oil_winbar()",
          signcolumn = "yes:2",
        },
      })
    end,
  },
  -- Git 状态集成，通过给文件名着色和添加状态符号来显示 Git 状态。
  {
    "benomahony/oil-git.nvim",
  },
}
