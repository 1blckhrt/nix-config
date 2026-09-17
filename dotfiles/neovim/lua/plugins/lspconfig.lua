return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local servers = {
			lua_ls = {},
			nil_ls = {},
			ruff = {},
			ty = {},
			sqruff = {},
			cssls = {},
			jsonls = {},
			rumdl = {},
		}

		for server_name, cfg in pairs(servers) do
			vim.lsp.config(server_name, cfg)
			vim.lsp.enable(server_name)
		end
	end,
}
