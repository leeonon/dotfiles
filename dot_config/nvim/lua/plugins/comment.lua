return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- 启用 Comment 插件并进行配置
    comment.setup({
      -- 使用 ts_context_commentstring 插件提供的 pre_hook 进行配置，以支持在 tsx、jsx、svelte 和 html 文件中更智能地处理注释。
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}
