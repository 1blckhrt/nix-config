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
			html = {},
			cssls = {},
			jsonls = {},
		}

		for server_name, cfg in pairs(servers) do
			vim.lsp.config(server_name, cfg)
			vim.lsp.enable(server_name)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		vim.lsp.config("markdown_oxide", {
			filetypes = { "markdown" },
			root_markers = { ".obsidian", ".git" },
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}),
		})

		vim.lsp.enable("markdown_oxide")

		vim.lsp.config("*", {
			on_attach = function(client, bufnr)
				if client:supports_method("workspace/diagnostic", bufnr) then
					vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
				else
					require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
				end
			end,
		})
	end,
}
