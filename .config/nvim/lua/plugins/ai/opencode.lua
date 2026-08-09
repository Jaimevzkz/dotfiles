return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {},
	},
	{
		"nickjvandyke/opencode.nvim",
		dependencies = {
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			vim.o.autoread = true

			-- vim.keymap.set({ "n", "x" }, "<leader>xa", function()
			-- 	require("opencode").ask("@this: ", { submit = true, focus = true })
			-- end, { desc = "Ask opencode…" })
			--
			-- vim.keymap.set({ "n", "x" }, "<leader>xe", function()
			-- 	require("opencode").select()
			-- end, { desc = "Execute opencode action…" })
			--
			-- vim.keymap.set({ "n", "t" }, "<leader>xt", function()
			-- 	require("opencode").toggle()
			-- end, { desc = "Toggle opencode" })
		end,
	},
}
