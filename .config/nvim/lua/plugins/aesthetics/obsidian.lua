return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = { -- Only load this plugin in obsidian vault
		"BufReadPre /home/vzkz/own-projects/Digital-Brain/*.md",
		"BufNewFile /home/vzkz/own-projects/Digital-Brain/*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "Digital brain",
				path = "/home/vzkz/own-projects/Digital-Brain",
			},
		},
		templates = {
			folder = "/home/vzkz/own-projects/Digital-Brain/Obsidian-Resources/Templates/",
			date_format = "%Y-%m-%d-%a",
			time_format = "%H:%M",
		},
	},
}
