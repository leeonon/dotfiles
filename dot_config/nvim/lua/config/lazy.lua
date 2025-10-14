local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.sql" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.astro" },
    -- TODO: layvim 的 svelte extras 目前有 bug, 其配置的 lsp didChangeWatchedFiles 会出错导致 lsp 退出
    { import = "lazyvim.plugins.extras.lang.svelte" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    -- 添加、删除、替换、查找、突出显示周围内容（例如括号、引号等）。
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    -- 代码片段
    { import = "lazyvim.plugins.extras.coding.luasnip" },
    -- 一键生成注释 <leader>cn
    { import = "lazyvim.plugins.extras.coding.neogen" },
    -- 任务管理器
    { import = "lazyvim.plugins.extras.editor.overseer" },
    -- 重构
    { import = "lazyvim.plugins.extras.editor.refactoring" },
    -- 基于 LSP 的重构
    { import = "lazyvim.plugins.extras.editor.inc-rename" },

    -- { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
    { import = "lazyvim.plugins.extras.coding.blink" },
    { import = "lazyvim.plugins.extras.editor.fzf" },
    { import = "lazyvim.plugins.extras.vscode" },

    -- AI Tools
    { import = "plugins.ai.avante" },
    { import = "plugins.ai.claude-code" },
    { import = "plugins.ai.opencode" },
    { import = "plugins.ai.sidekick" },
    { import = "lazyvim.plugins.extras.ai.copilot" },
    { import = "plugins.codecompanion.init" },

    { import = "plugins" },
    { import = "plugins.lsp" },
    { import = "plugins.format-linting" },
    { import = "plugins.git" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
