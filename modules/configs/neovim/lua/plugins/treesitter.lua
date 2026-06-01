return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.config").setup({
			sync_install = true,
			ensure_installed = { "lua", "python", "markdown", "nix" },
			highlight = { enable = true },
		})
	end,
}
