return {
	"echaya/neowiki.nvim",
	opts = {
		wiki_dirs = {
			{
				name = "Courses",
				path = "/run/media/blckhrt/Laptop Hard Drive/Notes/Courses",
			},
			{
				name = "Documentation",
				path = "/run/media/blckhrt/Laptop Hard Drive/Notes/Documentation",
			},
			{
				name = "SoftwareProjects",
				path = "/run/media/blckhrt/Laptop Hard Drive/Notes/SoftwareProjects",
			},
		},
	},
	keys = {
		{ "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>", desc = "Open Wiki" },
	},
}
