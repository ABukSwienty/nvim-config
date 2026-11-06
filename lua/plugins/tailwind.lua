-- No semver tags upstream; the commit is pinned in nvim-pack-lock.json
vim.pack.add({ 'https://github.com/razak17/tailwind-fold.nvim' })

-- Collapses class strings to the symbol below; the line under the cursor shows them in full.
-- :TailwindFoldToggle to show all classes. Uses the treesitter parsers from treesitter.lua.
require('tailwind-fold').setup({
  min_chars = 40, -- leave short class lists visible
})
