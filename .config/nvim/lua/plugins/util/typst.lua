return {
	{
		"kaarmu/typst.vim", -- Optional: provides better syntax highlighting
		ft = "typst",
		config = function()
			-- Path to tinymist (installed via Mason)
			local tinymist = vim.fn.stdpath("data") .. "/mason/bin/tinymist"

			-- Function to compile current typst file to PDF
			local function compile_typst()
				local input = vim.fn.expand("%:p")
				local output = vim.fn.expand("%:p:r") .. ".pdf"
				vim.fn.jobstart({ tinymist, "compile", input, output }, {
					on_exit = function(_, code)
						if code ~= 0 then
							vim.notify("Typst compilation failed", vim.log.levels.ERROR)
						end
					end,
				})
			end
			-- Function to open Zathura (won't open duplicate if already open)
			local function open_zathura()
				local pdf = vim.fn.expand("%:p:r") .. ".pdf"
				-- Check if zathura is already viewing this PDF
				vim.fn.jobstart({ "zathura", pdf }, { detach = true })
			end
			-- Compile and preview
			local function compile_and_preview()
				compile_typst()
				-- Small delay to ensure PDF is written before opening
				vim.defer_fn(open_zathura, 500)
			end
			-- Keymap: <leader>ct to compile and preview
			vim.keymap.set(
				"n",
				"<leader>ct",
				compile_and_preview,
				{ buffer = true, desc = "Compile Typst and preview in Zathura" }
			)
			-- Auto-compile on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*.typ",
				callback = compile_typst,
			})
		end,
	},
}
