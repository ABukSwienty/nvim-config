vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/refractalize/oil-git-status.nvim',  -- git status signs
})

require('oil').setup({
  default_file_explorer = true,
  watch_for_changes = true,
  delete_to_trash = true,                 -- deleted files go to the macOS Trash
  skip_confirm_for_simple_edits = true,   -- no prompt for simple renames/creates

  columns = {
    'icon',
    -- 'permissions',
    'size',
    'mtime',                              -- last modified
  },

  view_options = {
    show_hidden = true,
    is_always_hidden = function(name) return name == '.DS_Store' or name == '..' end,
  },

  win_options = {
    signcolumn = 'yes:2',                 -- room for git status signs
  },

  float = {
    padding = 4,
    max_width = 90,
    max_height = 30,
    border = 'rounded',
  },

  preview_win = {
    update_on_cursor_moved = true,        -- preview follows the cursor
  },
})

require('oil-git-status').setup({})

vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Explorer at current file dir' })
vim.keymap.set('n', '_', function() require('oil').open(vim.fn.getcwd()) end, { desc = 'Explorer at cwd' })
vim.keymap.set('n', '<leader>o', function() require('oil').toggle_float() end, { desc = 'Explorer (floating)' })

-- Make :Ex open oil
vim.api.nvim_create_user_command('Ex', function() require('oil').open() end, {})
