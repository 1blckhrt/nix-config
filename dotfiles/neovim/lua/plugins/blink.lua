return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	config = function()
		local blink = require("blink.cmp")
		blink.setup({
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			appearance = { nerd_font_variant = "normal" },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "snippets", "dadbod", "lsp", "buffer" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink", score_offset = 100 },
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			snippets = { preset = "luasnip" },
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
			signature = { enabled = true },
			completion = {
				documentation = {
					auto_show = false,
				},
				menu = {
					auto_show_delay_ms = 0,
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},
		})
	end,
}
