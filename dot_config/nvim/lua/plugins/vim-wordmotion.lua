-- 更好的 w e b 单词移动
return {
  "chaoren/vim-wordmotion",
  init = function()
    vim.g.wordmotion_mappings = { e = "k", ge = "gk" }
  end,
}
