-- Hook: rebuild parsers after the plugin updates.
-- Must be defined before vim.pack.add().
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

-- Parsers to install. Edit to match the languages in use.
-- Already-installed parsers are skipped; installation runs in the background.
require('nvim-treesitter').install({
  'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline',
  'bash', 'json', 'yaml', 'toml',
  'python', 'javascript', 'typescript', 'html', 'css', 'go', 'gomod', 'gosum','tsx',
})

-- Enable treesitter highlighting and indentation for any filetype with a parser
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
