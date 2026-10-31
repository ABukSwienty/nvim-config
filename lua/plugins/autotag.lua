vim.pack.add({
  'https://github.com/windwp/nvim-ts-autotag',
})

require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true,           -- <div> → <div></div>
    enable_rename = true,          -- renaming the opening tag renames the closing tag
    enable_close_on_slash = false, -- typing </ does not auto-complete the tag name
  },
})
