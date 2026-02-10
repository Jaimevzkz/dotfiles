return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		lazy = false,
	},
	{
		"folke/trouble.nvim",
	},
	{
		"AlexandrosAlexiou/kotlin.nvim",
		ft = { "kotlin" },
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"oil.nvim",
			"trouble.nvim",
		},
		config = function()
			require("kotlin").setup({
				inlay_hints = {
					enabled = true,
				},
			})
      --
			-- Code actions and quick fixes
			vim.keymap.set("n", "<leader>ka", ":KotlinCodeActions<CR>", { desc = "Kotlin code actions" })
			vim.keymap.set("n", "<leader>kq", ":KotlinQuickFix<CR>", { desc = "Kotlin quick fix" })

			-- Organize imports
			vim.keymap.set("n", "<leader>ko", ":KotlinOrganizeImports<CR>", { desc = "Organize Kotlin imports" })

			-- Format buffer
			vim.keymap.set("n", "<leader>kf", ":KotlinFormat<CR>", { desc = "Format Kotlin buffer" })

			-- Show symbols
			vim.keymap.set("n", "<leader>ks", ":KotlinSymbols<CR>", { desc = "Show document symbols" })

			-- Find references
			vim.keymap.set("n", "<leader>kr", ":KotlinReferences<CR>", { desc = "Find references" })

			-- Rename symbol
			vim.keymap.set("n", "<leader>kn", ":KotlinRename<CR>", { desc = "Rename symbol" })

			-- Toggle inlay hints
			vim.keymap.set("n", "<leader>kh", ":KotlinInlayHintsToggle<CR>", { desc = "Toggle inlay hints" })
		end,
	},
}
