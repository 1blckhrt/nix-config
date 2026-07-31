return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>st",
			function()
				Snacks.picker.todo_comments({ keywords = { "task", "Task", "ToDo", "todo", "Todo" } })
			end,
			desc = "Search Tasks",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.todo_comments({ keywords = { "Project", "project" } })
			end,
			desc = "Search Projects",
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.todo_comments({ keywords = { "INFO", "Info", "info", "Note", "note" } })
			end,
			desc = "Search Notes",
		},
	},
	opts = {
		keywords = {
			PROJECT = { icon = " ", color = "test", alt = { "Project", "project" } },
			TODO = { icon = " ", color = "info", alt = { "task", "Task", "ToDo", "todo", "Todo" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO", "Info", "info", "Note", "note" } },
		},
		highlight = {
			comments_only = false,
		},
	},
}
