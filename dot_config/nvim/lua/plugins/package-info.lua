return {
  "vuki656/package-info.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- 显示依赖版本
    vim.keymap.set(
      { "n" },
      "<leader>ps",
      require("package-info").show,
      { silent = true, noremap = true, desc = "Show package version" }
    )

    -- 异常依赖版本
    vim.keymap.set(
      { "n" },
      "<leader>pc",
      require("package-info").hide,
      { silent = true, noremap = true, desc = "Hide package version" }
    )

    -- 切换依赖版本
    vim.keymap.set(
      { "n" },
      "<leader>pt",
      require("package-info").toggle,
      { silent = true, noremap = true, desc = "Toggle package version" }
    )

    -- 更新依赖版本
    vim.keymap.set(
      { "n" },
      "<leader>pu",
      require("package-info").update,
      { silent = true, noremap = true, desc = "Update package version" }
    )

    -- 删除依赖
    vim.keymap.set(
      { "n" },
      "<leader>pd",
      require("package-info").delete,
      { silent = true, noremap = true, desc = "Delete package" }
    )

    -- 安装依赖
    vim.keymap.set(
      { "n" },
      "<leader>pi",
      require("package-info").install,
      { silent = true, noremap = true, desc = "Install package" }
    )

    -- 安装不同版本的依赖项
    vim.keymap.set(
      { "n" },
      "<leader>pp",
      require("package-info").change_version,
      { silent = true, noremap = true, desc = "Change package version" }
    )
  end,
}
