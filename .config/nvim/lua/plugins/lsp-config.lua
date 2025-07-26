return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {}, -- Leave this empty or add non-conflicting servers
				automatic_installation = false, -- Disable automatic installation
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LSP commands
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- Languages // Use the NixOS-provided server
			-- Lua
			lspconfig.lua_ls.setup({
				cmd = { "lua-language-server" },
				capabilities = capabilities,
			})
			-- Rust
			lspconfig.rust_analyzer.setup({
				cmd = { "rust-analyzer" },
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {},
				},
			})
			-- C/C++
			lspconfig.clangd.setup({
				cmd = { "clangd" },
				capabilities = capabilities,
				on_attach = on_attach,
			})
			-- Kotlin
			lspconfig.kotlin_language_server.setup({
				cmd = { "kotlin-language-server" },
				capabilities = capabilities,
				on_attach = on_attach,
			})
      -- Nix
			lspconfig.nil_ls.setup({
				cmd = { "nil" }, -- Use the `nil` language server binary
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
}
