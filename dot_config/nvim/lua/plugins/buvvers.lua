local MiniIcons = require("mini.icons")
return {
  "aidancz/buvvers.nvim",
  config = function()
    require("buvvers").setup({
      vim.keymap.set("n", "<leader>bl", require("buvvers").toggle, { desc = "Buvvers Toggle" }),
      name_prefix = function(buffer_handle)
        return "○ "
      end,
      buffer_handle_list_to_buffer_name_list = function(handle_l)
        local name_l

        local default_function = require("buvvers.buffer_handle_list_to_buffer_name_list")
        name_l = default_function(handle_l)

        for n, name in ipairs(name_l) do
          local icon, hl = MiniIcons.get("file", name)
          name_l[n] = {
            { icon .. " ", hl },
            name,
          }
        end

        return name_l
      end,
    })
  end,
}
