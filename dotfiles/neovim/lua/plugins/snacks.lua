return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sv",
			function()
				Snacks.picker.files({
					confirm = function(picker, item)
						picker:close()
						if item then
							vim.cmd("vsplit " .. item.file)
						end
					end,
				})
			end,
			desc = "Split vertically",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.files({
					confirm = function(picker, item)
						picker:close()
						if item then
							vim.cmd("split " .. item.file)
						end
					end,
				})
			end,
			desc = "Split horizontally",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gb",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<C-t>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
			mode = { "n", "t" },
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>se",
			function()
				Snacks.picker.diagnostics({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Search Errors",
		},
	},
	opts = {
		indent = { enabled = true },
		terminal = {
			enabled = true,
			win = {
				position = "float",
				width = 0.6,
				height = 0.8,
				border = "rounded",
			},
		},
		picker = {
			enabled = true,
			matcher = {
				frecency = true,
			},
			sources = {
				files = { hidden = true },
				grep = { hidden = true },
				explorer = { hidden = true },
			},
		},
		scratch = {
			ft = "markdown",
		},
		dashboard = {
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1 },
				{ section = "startup" },
			},
		},
		input = { enabled = true },
	},
}
