local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })

-- Cheatsheet in a floating window, from any project (file lives in the nvim config dir)
map("n", "<leader>?", function()
  local path = vim.fn.stdpath("config") .. "/cheatsheet.md"
  local buf = vim.fn.bufadd(path)
  vim.fn.bufload(buf)
  local width = math.min(90, math.floor(vim.o.columns * 0.8))
  local height = math.floor(vim.o.lines * 0.8)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = "rounded",
    title = " Cheatsheet ",
    title_pos = "center",
  })
  vim.keymap.set("n", "q", "<cmd>write | close<CR>", { buffer = buf, desc = "Save and close cheatsheet" })
end, { desc = "Open cheatsheet" })

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
