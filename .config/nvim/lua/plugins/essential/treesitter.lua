-- nvim-treesitter, `main` branch.
--
-- The old `master` branch is frozen and its markdown injection query uses a
-- `set-lang-from-info-string!` directive that is incompatible with Neovim
-- 0.11+ (a query match is now a list of nodes, not a single node). That is
-- what threw "attempt to call method 'range' (a nil value)" on every .md file
-- containing a fenced code block.
--
-- `main` no longer has modules: highlighting/indent are wired up by hand below.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	-- Mason provides the `tree-sitter` CLI on $PATH, which `main` needs in
	-- order to build parsers, so it has to load first.
	dependencies = { "williamboman/mason.nvim" },
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup()

		-- markdown_inline is required alongside markdown, otherwise inline
		-- markup inside .md files is left unhighlighted.
		local ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"csv",
			"diff",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"groovy",
			"html",
			"ini",
			"java",
			"json",
			"kotlin",
			"lua",
			"luadoc",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"rust",
			"toml",
			"typst",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		}

		local function not_installed(languages)
			local installed = {}
			for _, lang in ipairs(ts.get_installed("parsers")) do
				installed[lang] = true
			end
			return vim.tbl_filter(function(lang)
				return not installed[lang]
			end, languages)
		end

		local missing = not_installed(ensure_installed)
		if #missing > 0 then
			ts.install(missing)
		end

		local function ts_attach(buf, lang)
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			if not pcall(vim.treesitter.start, buf, lang) then
				return
			end
			vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end

		-- Replaces the old `highlight`/`indent`/`auto_install` modules.
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang then
					return
				end

				if #not_installed({ lang }) == 0 then
					ts_attach(args.buf, lang)
					return
				end

				-- auto_install: pull the parser, then highlight once it lands.
				if vim.list_contains(ts.get_available(), lang) then
					ts.install(lang):await(function()
						vim.schedule(function()
							ts_attach(args.buf, lang)
						end)
					end)
				end
			end,
		})
	end,
}
