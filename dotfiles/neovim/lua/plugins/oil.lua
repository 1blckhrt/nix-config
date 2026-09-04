return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		require("oil").setup({
			delete_to_trash = true,
			keymaps = { ["q"] = { "actions.close", mode = "n" } },
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			view_options = { show_hidden = true },
			float = { max_width = 0.65, max_height = 0.65, border = "rounded", preview_split = "right" },
		})
		vim.keymap.set("n", "<leader>e", "<CMD>Oil --preview --float .<CR>", { desc = "Open Explorer" })
	end,
}
