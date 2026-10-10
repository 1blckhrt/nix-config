return {
	"echaya/neowiki.nvim",
	opts = {
		wiki_dirs = {
			{ name = "Personal", path = "/home/blckhrt/Notes" },
		},
		index_file = "README.md",
	},
	keys = {
		{
			"<leader>wk",
			"<cmd>lua require('neowiki').open_wiki('Personal')<cr>",
			desc = "Open Wiki in Floating Window",
		},
	},
}
