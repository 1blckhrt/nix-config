return {
	{
		"RRethy/base16-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("base16-colorscheme").setup(require("theme-palette"))

			for _, group in ipairs({
				"Normal",
				"NormalNC",
				"NormalFloat",
				"FloatBorder",
				"FloatTitle",
				"SignColumn",
				"LineNr",
				"FoldColumn",
				"EndOfBuffer",
				"VertSplit",
				"WinSeparator",
				"StatusLine",
				"StatusLineNC",
			}) do
				local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
				hl.bg = nil
				vim.api.nvim_set_hl(0, group, hl)
			end
		end,
	},
}
