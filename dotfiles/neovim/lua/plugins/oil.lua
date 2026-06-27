return {
	"stevearc/oil.nvim",
	keys = {
		{
			"<leader>e",
			function()
				require("oil").toggle_float(".")
			end,
			desc = "Open File Browser",
		},
	},
	opts = {
		delete_to_trash = true,
		keymaps = { ["q"] = { "actions.close", mode = "n" } },
		default_file_explorer = true,
		view_options = { show_hidden = true },
		float = { padding = 2, max_width = 60, max_height = 20, border = "rounded" },
	},
}
