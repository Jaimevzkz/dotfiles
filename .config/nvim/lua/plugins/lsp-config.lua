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
				-- ensure_installed = { "lua_ls", "kotlin_language_server", "rust_analyzer", "gopls" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Define configs
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("kotlin_language_server", {
				capabilities = capabilities,
			})

			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
			})

			-- Automatically start attached servers for opened buffers
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local clients = {
						lua = "lua_ls",
						kotlin = "kotlin_language_server",
						rust = "rust_analyzer",
					}
					local server = clients[ft]
					if server then
						vim.lsp.start(vim.lsp.config(server))
					end
				end,
			})

			-- LSP keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
