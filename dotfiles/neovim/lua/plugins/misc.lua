return {
	{ "nvim-lua/plenary.nvim" },
	{ "wakatime/vim-wakatime", lazy = false },

	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{ "L3MON4D3/LuaSnip", opts = {} },
	{ "xzbdmw/colorful-menu.nvim", opts = {} },
	{
		"rachartier/tiny-code-action.nvim",
		event = "LspAttach",
		config = function()
			vim.keymap.set({ "n", "x" }, "<leader>ca", function()
				require("tiny-code-action").code_action()
			end, { noremap = true, silent = true, desc = "Code Actions" })
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
}
