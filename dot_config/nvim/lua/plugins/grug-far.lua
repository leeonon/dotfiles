return {
  "MagicDuck/grug-far.nvim",
  enabled = true,
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      nil,
      mode = { "n", "v" },
      desc = "搜索和替换",
    },
    {
      "<leader>srr",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "v" },
      desc = "搜索和替换",
    },
    {
      "<leader>srw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      mode = { "n", "v" },
      desc = "搜索并替换光标下的单词",
    },
    {
      "<leader>srf",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n", "v" },
      desc = "在当前文件中搜索和替换",
    },
  },
}
