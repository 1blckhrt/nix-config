return {
	{
		"RRethy/base16-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local palette = require("theme-palette")
			require("base16-colorscheme").setup(palette)
		end,
	},
}
