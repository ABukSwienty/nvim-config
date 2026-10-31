vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

-- Server-specific settings (must come before servers are enabled)
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { library = { vim.env.VIMRUNTIME } },  -- makes `vim.*` known
    },
  },
})

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindCSS = {
      experimental = {
        -- complete classes inside clsx()/cn()/cva() calls, not just class attributes
        classRegex = {
          { 'clsx\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { 'cn\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { 'cva\\(([^)]*)\\)', "[\"'`]([^\"'`]*).*?[\"'`]" },
        },
      },
    },
  },
})

-- Install servers and enable them automatically
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'ts_ls', 'eslint', 'gopls', 'html', 'cssls', 'jsonls', 'lua_ls', 'tailwindcss' },
  automatic_enable = true,
})

-- Diagnostics display
vim.diagnostic.config({
  virtual_text = true,      -- inline error text at end of line
  severity_sort = true,     -- errors before warnings
  float = { border = 'rounded' },
})

-- Keymaps active only in buffers with an LSP server attached
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local map = function(keys, fn, desc)
      vim.keymap.set('n', keys, fn, { buffer = ev.buf, desc = desc })
    end
    local tb = require('telescope.builtin')

    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('<leader>fs', tb.lsp_document_symbols, 'Symbols in file')
    map('<leader>fS', tb.lsp_dynamic_workspace_symbols, 'Symbols in project')
    map('<leader>fd', tb.diagnostics, 'Diagnostics list')
    map('<leader>e', vim.diagnostic.open_float, 'Show diagnostic under cursor')
  end,
})
