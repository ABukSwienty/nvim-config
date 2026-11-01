vim.pack.add({
  { src = 'https://github.com/folke/ts-comments.nvim', version = vim.version.range('^1') },
})

-- Treesitter-aware commentstring for built-in gc (e.g. {/* */} inside JSX)
require('ts-comments').setup({})
