vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})

local prettier = { 'prettierd', 'prettier', stop_after_first = true }  -- prettierd, else prettier

require('conform').setup({
  formatters_by_ft = {
    javascript      = prettier,
    javascriptreact = prettier,
    typescript      = prettier,
    typescriptreact = prettier,
    json            = prettier,
    jsonc           = prettier,
    css             = prettier,
    scss            = prettier,
    html            = prettier,
    yaml            = prettier,
    markdown        = prettier,
    go              = { 'goimports' },
    lua             = { 'stylua' },
  },

  -- Format on every save; use the LSP formatter if no formatter is listed for the filetype
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = 'fallback',
  },
})

-- Manual format (normal mode: whole file; visual mode: selection)
vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format file or selection' })

-- Make the gq operator use conform
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
