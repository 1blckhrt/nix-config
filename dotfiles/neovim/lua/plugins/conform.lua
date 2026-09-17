return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			nix = { "nixfmt" },
			markdown = { "rumdl" },
			json = { "prettierd", "prettier", stop_after_first = true },
			sql = { "sqruff" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
