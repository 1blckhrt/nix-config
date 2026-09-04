return {
	{
		"RRethy/base16-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local palette = require("theme-palette")
			require("base16-colorscheme").setup(palette)

			for _, group in ipairs({
				"Normal",
				"NormalNC",
				"NormalFloat",
				"SignColumn",
				"LineNr",
				"FoldColumn",
				"EndOfBuffer",
				"VertSplit",
				"WinSeparator",
				"StatusLine",
				"StatusLineNC",
			}) do
				vim.api.nvim_set_hl(0, group, { bg = "none" })
			end
		end,
	},
}
