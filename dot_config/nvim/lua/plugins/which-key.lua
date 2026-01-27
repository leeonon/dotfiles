return {
  "folke/which-key.nvim",
  opts = {
    -- classic | modern | helix
    preset = "classic",
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Use the new spec format
    wk.add({
      -- HTML/Tags group
      { "<leader>h", group = "html/tags" },
      { "<leader>ht", "vat", desc = "Select outer tag" },
      { "<leader>hi", "vit", desc = "Select inner tag" },
      { "<leader>hd", "dat", desc = "Delete outer tag" },
      { "<leader>hc", "cit", desc = "Change inner tag" },
      { "<leader>hC", "cat", desc = "Change outer tag" },
    })
  end,
}
