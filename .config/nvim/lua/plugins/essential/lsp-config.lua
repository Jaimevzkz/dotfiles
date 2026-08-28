return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()

			-- mason-lspconfig only manages LSP servers, so non-LSP tools used by
			-- none-ls (linters/formatters) are installed here.
			local tools = {
				"markdownlint", -- markdown linting + --fix formatting
				"stylua",
				-- nvim-treesitter's `main` branch shells out to the tree-sitter
				-- CLI to build parsers; without it every install fails with
				-- ENOENT: 'tree-sitter'.
				"tree-sitter-cli",
			}

			local registry = require("mason-registry")
			registry.refresh(function()
				for _, name in ipairs(tools) do
					local ok, pkg = pcall(registry.get_package, name)
					if ok and not pkg:is_installed() then
						pkg:install()
					end
				end
			end)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- Note: `automatic_installation` is a v1 option and is ignored by
			-- mason-lspconfig v2 — use `ensure_installed` instead.
			--
			-- gopls is deliberately absent: Mason installs it with
			-- `go install golang.org/x/tools/gopls@latest`, and current gopls
			-- requires Go >= 1.26 while Tiledmedia's toolchain is 1.23.2, so the
			-- install always fails. It is wired up from GOPATH below instead.
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jsonls",
					"marksman",
					"rust_analyzer",
					"tinymist",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- The LSP log is append-only and never rotated; left on it grows to
			-- gigabytes and Neovim then nags about it on every startup. Raise this
			-- to "warn" or "debug" temporarily when debugging a server.
			vim.lsp.log.set_level("off")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- These are nvim-lspconfig config names (see `:h lspconfig-all`),
			-- not Mason package names. Previously `lua_language_server` and
			-- `json_lsp` were used, which do not exist, so those two servers
			-- never started.
			local servers = {
				"lua_ls",
				"jsonls",
				"marksman", -- markdown: links, headings, references
				"kotlin_lsp",
				"rust_analyzer",
				"tinymist",
			}

			for _, server in ipairs(servers) do
				vim.lsp.config[server] = {
					capabilities = capabilities,
				}
				vim.lsp.enable(server)
			end

			-- gopls: use the binary built against Tiledmedia's Go toolchain rather
			-- than a Mason-managed one (see the mason-lspconfig block above).
			-- Prefer $PATH, then fall back to GOPATH/bin for when Neovim is
			-- started outside a login shell and the Tiledmedia dirs are missing
			-- from $PATH.
			local gopls = vim.fn.exepath("gopls")
			if gopls == "" then
				local gopath = vim.trim(vim.fn.system({ "go", "env", "GOPATH" }))
				if vim.v.shell_error == 0 and gopath ~= "" then
					local candidate = vim.fs.joinpath(gopath, "bin", "gopls")
					if vim.uv.fs_stat(candidate) then
						gopls = candidate
					end
				end
			end

			if gopls ~= "" then
				vim.lsp.config["gopls"] = {
					capabilities = capabilities,
					cmd = { gopls },
				}
				vim.lsp.enable("gopls")
			end

			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
		end,
	},
}
