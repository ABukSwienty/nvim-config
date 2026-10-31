vim.pack.add({ 'https://github.com/akinsho/toggleterm.nvim' })

require('toggleterm').setup({
  size = function(term)
    if term.direction == 'horizontal' then return 15 end
    if term.direction == 'vertical' then return math.floor(vim.o.columns * 0.4) end
  end,
  direction = 'horizontal',   -- default: bottom panel
  persist_size = true,
  shade_terminals = false,    -- background handled by the TermNormal highlight
  float_opts = { border = 'rounded' },
})

local Terminal = require('toggleterm.terminal').Terminal
local map = vim.keymap.set

-- Main terminal (bottom): Space t t in normal mode, Alt-t from anywhere
map('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
map({ 'n', 't' }, '<M-t>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })

-- Floating terminal (never replaces a window)
map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Floating terminal' })

-- Claude Code (right side, persistent)
local claude = Terminal:new({ cmd = 'claude', direction = 'vertical', hidden = true })
map('n', '<leader>tc', function() claude:toggle() end, { desc = 'Toggle Claude Code' })

-- All terminals at once
map('n', '<leader>ta', '<cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle all terminals' })
