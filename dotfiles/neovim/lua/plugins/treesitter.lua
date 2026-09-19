return {
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.config").setup({
				sync_install = true,
				ensure_installed = {
					"lua",
					"python",
					"markdown",
					"markdown-inline",
					"nix",
					"sql",
					"json",
					"bash",
					"html",
					"css",
				},
				highlight = { enable = true },
				indent = {
					enable = true,
				},
			})
		end,
	},
}
