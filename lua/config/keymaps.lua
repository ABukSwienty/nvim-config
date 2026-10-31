local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })

-- Terminal
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Window navigation with Ctrl + h/j/k/l (normal and terminal mode)
map({ "n", "t" }, "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Window left" })
map({ "n", "t" }, "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Window down" })
map({ "n", "t" }, "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Window up" })
map({ "n", "t" }, "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Window right" })

-- Move line / selection up and down (no Alt: left Option types Danish characters)
map("n", "]e", "<cmd>move .+1<CR>==", { desc = "Move line down" })
map("n", "[e", "<cmd>move .-2<CR>==", { desc = "Move line up" })
map("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
map("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
