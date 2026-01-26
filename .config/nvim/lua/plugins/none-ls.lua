return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Stylua formatting for Lua
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.diagnostics.ktlint,
        null_ls.builtins.formatting.ktfmt,
        null_ls.builtins.formatting.gci,
        null_ls.builtins.formatting.fixjson,
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

