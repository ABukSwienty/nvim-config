vim.pack.add({
  { src = 'https://github.com/kevinhwang91/nvim-hlslens', version = vim.version.range('^1') },
})

require('hlslens').setup({})

-- Wrap search motions so the [n/N] lens shows next to each match
local map = vim.keymap.set
local lens = [[<cmd>lua require('hlslens').start()<CR>]]
map('n', 'n', [[<cmd>execute('normal! ' . v:count1 . 'n')<CR>]] .. lens, { desc = 'Next match' })
map('n', 'N', [[<cmd>execute('normal! ' . v:count1 . 'N')<CR>]] .. lens, { desc = 'Previous match' })
map('n', '*', '*' .. lens, { desc = 'Search word forward' })
map('n', '#', '#' .. lens, { desc = 'Search word backward' })
map('n', 'g*', 'g*' .. lens, { desc = 'Search partial word forward' })
map('n', 'g#', 'g#' .. lens, { desc = 'Search partial word backward' })
