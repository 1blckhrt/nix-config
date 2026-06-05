return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
	},
	opts = {
		size = 20,
		direction = "float",
		open_mapping = [[<c-t>]],
		float_opts = {
			border = "curved",
		},
	},
}
