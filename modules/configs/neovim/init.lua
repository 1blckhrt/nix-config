vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200
vim.opt.timeoutlen = 250
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.scrolloff = 10
vim.opt.smartindent = true
vim.opt.fillchars = { eob = " " }
vim.opt.confirm = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.showmatch = true
vim.o.laststatus = 3
vim.o.confirm = true
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

local map = vim.keymap.set

map("n", ";", ":")
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "p", '"_dP')
map("n", "<left>", '<cmd>echo "Use h to move!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!"<CR>')
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

if mnw ~= nil then
	require("lazy").setup({
		dev = {
			path = mnw.configDir .. "/pack/mnw/opt",
			patterns = { "" },
			fallback = true,
		},

		performance = {
			reset_packpath = false,
			rtp = {
				reset = false,
			},
		},

		install = {
			missing = true,
		},

		spec = {
			{ import = "plugins" },
		},
	})
else
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup({
		spec = {
			{ import = "plugins" },
		},
	})
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("persistence").setup({})
		require("persistence").load()
		vim.cmd([[filetype detect]])
	end,
})
