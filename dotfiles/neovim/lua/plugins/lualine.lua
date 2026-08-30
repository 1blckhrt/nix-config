local palette = require("theme-palette")

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			theme = {
				normal = {
					a = { bg = palette.base0D, fg = palette.base00, gui = "bold" },
					b = { bg = palette.base02, fg = palette.base05 },
					c = { bg = palette.base01, fg = palette.base04 },
				},
				insert = { a = { bg = palette.base0B, fg = palette.base00, gui = "bold" } },
				visual = { a = { bg = palette.base0E, fg = palette.base00, gui = "bold" } },
			},
			globalstatus = true,
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" } } },
			lualine_b = { "filename" },
			lualine_c = {
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					end,
					icon = "󰉋",
				},
			},
			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = { "lsp_status" },
		},
	},
}
