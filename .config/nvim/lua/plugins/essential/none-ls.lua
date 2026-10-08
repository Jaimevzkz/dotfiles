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
					--
					-- Markdown is errors-only: style warnings (line length, blank lines
					-- around headings, ...) are noise while writing. markdownlint reports
					-- everything as WARN, so in practice nothing is shown, but `<leader>gf`
					-- still runs `markdownlint --fix`. The same filter is applied to
					-- marksman in lsp-config.lua.
					null_ls.builtins.diagnostics.markdownlint.with({
						filter = function(diagnostic)
							return diagnostic.severity == vim.diagnostic.severity.ERROR
						end,
					}),
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
