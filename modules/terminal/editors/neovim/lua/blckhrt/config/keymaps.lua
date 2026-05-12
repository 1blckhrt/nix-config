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
