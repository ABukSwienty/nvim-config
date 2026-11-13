vim.pack.add({
  'https://github.com/nvimdev/dashboard-nvim', -- no semver tags; icons come from nvim-web-devicons (statusline.lua)
})

require('dashboard').setup({
  theme = 'hyper',
  config = {
    week_header = { enable = true },   -- header with date and time

    shortcut = {
      { desc = ' Find file', group = 'Label', key = 'f', action = 'Telescope find_files' },
      { desc = ' Recent', group = 'Label', key = 'r', action = 'Telescope oldfiles' },
      { desc = ' Grep', group = 'Label', key = 'g', action = 'Telescope live_grep' },
      { desc = ' Projects', group = 'Label', key = 'p', action = function()
          require('telescope.builtin').find_files({ cwd = '~' })
        end },
      { desc = ' Config', group = 'Label', key = 'c', action = 'edit ' .. vim.fn.stdpath('config') .. '/init.lua' },
      { desc = ' Quit', group = 'Label', key = 'q', action = 'qa' },
    },

    -- Recent projects: selecting one makes it the cwd and opens the file finder there
    project = {
      enable = true,
      limit = 8,
      action = function(path)
        vim.cmd.cd(path)
        require('telescope.builtin').find_files({ cwd = path })
      end,
    },

    -- Recently opened files
    mru = { enable = true, limit = 10, cwd_only = false },

    footer = {},
  },
})
