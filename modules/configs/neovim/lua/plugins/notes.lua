return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		templates = {
			folder = "~/Documents/Vault/_Templates",
		},
		ui = {
			enable = false,
		},
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Vault",
			},
		},
		picker = {
			name = "snacks.picker",
		},
	},
}
