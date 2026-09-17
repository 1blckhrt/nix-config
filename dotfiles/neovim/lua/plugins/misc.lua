return {
	{ "nvim-lua/plenary.nvim" },
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				},
			})

			local function tmux_command(command)
				local tmux_socket = vim.fn.split(vim.env.TMUX, ",")[1]
				return vim.fn.system("tmux -S " .. tmux_socket .. " " .. command)
			end

			local nvim_tmux_nav_group = vim.api.nvim_create_augroup("NvimTmuxNavigation", {})

			vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
				group = nvim_tmux_nav_group,
				callback = function()
					tmux_command("set-option -p @is_vim yes")
				end,
			})

			vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
				group = nvim_tmux_nav_group,
				callback = function()
					tmux_command("set-option -p -u @is_vim")
				end,
			})
		end,
	},
	{ "onsails/lspkind.nvim", opts = {} },
	{ "L3MON4D3/LuaSnip" },
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
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
				presets = {
					bottom_search = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
