return {
	"echaya/neowiki.nvim",
	opts = {
		wiki_dirs = {
			{
				name = "Courses",
				path = "/home/blckhrt/dev/notes/Courses/",
			},
			{
				name = "Documentation",
				path = "/home/blckhrt/dev/notes/Documentation",
			},
			{
				name = "SoftwareProjects",
				path = "/home/blckhrt/dev/notes/SoftwareProjects",
			},
		},
	},
	keys = {
		{ "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>", desc = "Open Wiki" },
	},
}
