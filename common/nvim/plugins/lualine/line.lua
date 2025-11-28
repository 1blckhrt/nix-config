require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,

		component_separators = {
			left = "",
			right = "",
		},

		section_separators = {
			left = "",
			right = "",
		},
	},

	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},

		lualine_b = { "filename" },

		lualine_c = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = "  ",
					warn = "  ",
					info = "  ",
					hint = "  ",
				},
			},
		},

		lualine_x = {},

		lualine_y = {
			{
				"filetype",
				cond = function()
					local hide = { TelescopePrompt = true, toggleterm = true }
					return not hide[vim.bo.filetype]
				end,
			},
			{
				"lsp",
				fmt = function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					for _, client in pairs(clients) do
						if client.name ~= "copilot" then
							return "  " .. client.name
						end
					end
					return "  off"
				end,
			},
		},

		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},

	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},

	tabline = {},
	extensions = {},
})
