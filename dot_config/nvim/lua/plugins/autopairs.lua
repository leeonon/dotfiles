return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      check_ts = true, -- enable treesitter
      -- 为特定语言配置 Tree-sitter 的行为：
      ts_config = {
        lua = { "string" }, -- 在 Lua 中的字符串节点内不自动添加成对符号。
        javascript = { "template_string" }, -- 在 JavaScript 的模板字符串节点内不自动添加成对符号。
      },
    })

    -- 导入 nvim-autopairs 与 nvim-cmp 的集成功能
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- 导入 nvim-autopairs 插件的补全功能模块，以便与 nvim-cmp 结合使用。
    local cmp = require("cmp")

    -- 	监听 nvim-cmp 的 confirm_done 事件（当补全项被确认时触发），并调用 nvim-autopairs 的 on_confirm_done 方法,使得括号补全功能与代码补全功能能够协同工作。
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
