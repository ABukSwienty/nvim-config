vim.pack.add({
  { src = 'https://github.com/folke/ts-comments.nvim', version = vim.version.range('^1') },
})

-- Treesitter-aware commentstring for built-in gc (e.g. {/* */} inside JSX)
require('ts-comments').setup({})

-- Comment format for JSX/TSX files (ts-comments switches to {/* */} inside JSX markup)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescriptreact', 'javascriptreact' },
  callback = function()
    vim.bo.commentstring = '// %s'
  end,
})
