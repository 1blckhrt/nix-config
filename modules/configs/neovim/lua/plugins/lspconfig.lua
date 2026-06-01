return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local servers = {
			nil_ls = {},
			ruff = {},
			pyrefly = {},
			lua_ls = {},
		}

		for server_name, cfg in pairs(servers) do
			vim.lsp.config(server_name, cfg)
			vim.lsp.enable(server_name)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		vim.lsp.config("markdown_oxide", {
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}),
		})

		vim.lsp.enable("markdown_oxide")
	end,
}
