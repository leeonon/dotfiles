return {
  "tamton-aquib/duck.nvim",
  config = function()
    vim.keymap.set("n", "<leader>;d", function()
      require("duck").hatch()
    end, {
      desc = "🦆 Duck",
    })
    vim.keymap.set("n", "<leader>;k", function()
      require("duck").cook()
    end, {
      desc = "🦆 Cook",
    })
    vim.keymap.set("n", "<leader>;a", function()
      require("duck").cook_all()
    end, {
      desc = "🦆 Cook All",
    })
  end,
}
