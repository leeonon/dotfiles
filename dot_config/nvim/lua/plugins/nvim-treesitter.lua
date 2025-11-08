-- https://www.youtube.com/watch?v=CEMPq_r8UYQ&t=484s

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = {
        enable = true,
        -- NOTE: 启用缩进功能会显著降低Dart文件的编辑速度。
        -- https://github.com/nvim-flutter/flutter-tools.nvim/issues/267#issuecomment-1616728174
        disable = { "dart" },
      },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "tsx",
        "scss",
        "json",
        "javascript",
        "typescript",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "http",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "astro",
        "rust",
      },
    },
  },
}
