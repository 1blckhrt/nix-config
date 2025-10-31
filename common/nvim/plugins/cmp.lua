local ok, cmp = pcall(require, "cmp")

if ok then
	cmp.setup.cmdline({ "/", "?" }, {
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	require("copilot").setup()
end
