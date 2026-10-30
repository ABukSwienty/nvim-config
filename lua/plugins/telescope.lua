vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',  -- dependency, listed first
  'https://github.com/nvim-telescope/telescope.nvim',
})

require('telescope').setup({})

local builtin = require('telescope.builtin')
local map = vim.keymap.set
map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
map('n', '<leader>fg', builtin.live_grep,  { desc = 'Grep text in project' })
map('n', '<leader>fb', builtin.buffers,    { desc = 'Open buffers' })
map('n', '<leader>fr', builtin.oldfiles,   { desc = 'Recent files' })
map('n', '<leader>fh', builtin.help_tags,  { desc = 'Search help' })
map('n', '<leader>fk', builtin.keymaps,    { desc = 'Search keymaps' })
