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
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Define your servers here
			local servers = {
				"lua_language_server",
				--"kotlin_language_server",
				--"kotlin_lsp",
				"rust_analyzer",
			}

			for _, server in ipairs(servers) do
				vim.lsp.config[server] = {
					capabilities = capabilities,
				}
				vim.lsp.enable(server)
			end

			-- gopls (using custom Go installation, not Mason)
			vim.lsp.config.gopls = {
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			}
			vim.lsp.enable("gopls")

			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
		end,
	},
}
