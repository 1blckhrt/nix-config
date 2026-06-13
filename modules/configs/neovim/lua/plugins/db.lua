return {
	"zerochae/dbab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"tpope/vim-dadbod",
	},
	config = function()
		require("dbab").setup({
			connections = {
				{
					name = "uni",
					url = "sqlite:///home/blckhrt/.local/share/uni-python/uni.db",
				},
			},
		})
		vim.keymap.set("n", "<leader>db", "<cmd>Dbab<CR>")
	end,
}
