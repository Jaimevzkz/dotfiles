return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local harpoon = require("harpoon").setup({})

		vim.keymap.set("n", "<leader>h", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>hd", function()
			harpoon:list():remove()
		end)
		vim.keymap.set("n", "<leader>j", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<C-u>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-i>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-o>", function()
			harpoon:list():select(3)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>p", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n",  "<leader>n", function()
			harpoon:list():next()
		end)
	end,
}
