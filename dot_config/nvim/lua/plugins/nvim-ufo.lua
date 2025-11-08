-- 代码折叠增强

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d 行 "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost", -- You can make it lazy-loaded via VeryLazy, but comment out if thing doesn't work
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "打开所有折叠" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "关闭所有折叠" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "打开折叠" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "关闭当前折叠" }) -- closeAllFolds == closeFoldsWith(0)
    end,
    config = function()
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        oepn_fold_hl_timeout = 0,
        -- fold_virt_text_handler = handler,
      })
    end,
  },
  -- 折叠预览功能,默认使用 h 和 l 键。
  -- 首次按下 h 键时,如果光标位于已折叠的区域,则预览将会显示。
  -- 第二次按下 h 键,预览将关闭并展开折叠。
  -- 当预览打开时,按下 l 键将关闭预览并展开折叠。在其他情况下,这些键将正常工作。
  { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
}
