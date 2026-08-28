return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Stylua formatting for Lua
					null_ls.builtins.formatting.stylua,

					-- Markdown linting + formatting (markdownlint-cli, one binary for both).
					-- diagnostics.markdownlint lints via stdin, so it updates as you type;
					-- the cli2 variant only runs on save.
					null_ls.builtins.diagnostics.markdownlint,
					null_ls.builtins.formatting.markdownlint,
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "simple",
				signs = false,
			})
		end,
	},
}
