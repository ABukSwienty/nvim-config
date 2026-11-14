vim.pack.add({
  { src = 'https://github.com/MagicDuck/grug-far.nvim', version = vim.version.range('^1') },
})

require('grug-far').setup({})

vim.keymap.set('n', '<leader>sr', '<cmd>GrugFar<CR>', { desc = 'Search and replace (project)' })
