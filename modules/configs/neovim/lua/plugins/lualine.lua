return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			theme = "auto",
			globalstatus = true,
		},
		sections = {
			lualine_z = { "lsp_status" },
		},
	},
}
