return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "simrat39/rust-tools.nvim",
  },
  config = function()
    local keymap = vim.keymap

    require("lspsaga").setup({
      ui = {
        border = "rounded",
        -- code_action = "🫡",
        code_action = "",
      },
    })

    local builtin = require("telescope.builtin")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { buffer = ev.buf })
        vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<cr>", { buffer = ev.buf, desc = "✍️  Lspsaga Rename" })
        vim.keymap.set({ "n", "v" }, "<space>ca", "<cmd>Lspsaga code_action<cr>", { buffer = ev.buf })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = ev.buf })
      end,
    })

    -- for crates.nvim
    local function show_documentation()
      local filetype = vim.bo.filetype
      if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
      elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
      elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
        require("crates").show_popup()
      else
        vim.cmd("Lspsaga hover_doc")
      end
    end

    vim.keymap.set("n", "<space>k", show_documentation, { silent = true })

    -- error lens
    vim.fn.sign_define({
      {
        name = "DiagnosticSignError",
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "ErrorLine",
      },
      {
        name = "DiagnosticSignWarn",
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "WarningLine",
      },
      {
        name = "DiagnosticSignInfo",
        text = "",
        texthl = "DiagnosticSignInfo",
        linehl = "InfoLine",
      },
      {
        name = "DiagnosticSignHint",
        text = "",
        texthl = "DiagnosticSignHint",
        linehl = "HintLine",
      },
    })
  end,
}
