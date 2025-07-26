return {
	{ "ixru/nvim-markdown", ft = "markdown" },
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1 -- Automatically open preview when editing Markdown files
      vim.keymap.set('n', '<leader>cm', ':MarkdownPreview<CR>')
		end,
	},
}
