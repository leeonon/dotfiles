return {
  -- 重命名高亮 <leader>cr
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  {
    "editorconfig/editorconfig-vim",
  },
  -- 保存时删除 EOF 处的尾随空格和空行
  {
    "mcauley-penney/tidy.nvim",
    config = true,
  },
}
