-- In-buffer markdown rendering: headings, bullets, checkboxes, code blocks,
-- tables and links are drawn with icons/highlights instead of raw syntax.
-- Rendering is applied in normal mode only; the cursor line and the whole
-- buffer in insert mode show the raw text so editing is not affected.
-- Needs the `markdown` and `markdown_inline` treesitter parsers (installed
-- via treesitter.lua) and `conceallevel` >= 2 (set in init.lua).
return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- Show the raw markup on the cursor line so it stays easy to edit.
		anti_conceal = { enabled = true },
		-- Code block background only as wide as the longest line, not the window.
		code = { width = "block" },
	},
}
