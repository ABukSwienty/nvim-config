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

    -- Recent projects: selecting one makes it the cwd and opens oil at the project root
    project = {
      enable = true,
      limit = 8,
      action = function(path)
        vim.cmd.cd(path)
        require('oil').open(path)
      end,
    },

    -- Recently opened files
    mru = { enable = true, limit = 10, cwd_only = false },

    footer = {},
  },
})

-- dashboard-nvim only records LSP roots, only in sessions where the dashboard was shown,
-- and writes asynchronously on exit (often lost). Record the cwd's git root ourselves instead.
vim.api.nvim_create_autocmd('VimLeavePre', {
  group = vim.api.nvim_create_augroup('DashboardProjects', { clear = true }),
  callback = function()
    local git = vim.fs.find('.git', { path = vim.fn.getcwd(), upward = true })[1]
    if not git then return end
    local root = vim.fs.dirname(git)

    local path = vim.fn.stdpath('cache') .. '/dashboard/cache'
    local ok, list = pcall(dofile, path)
    if not ok or type(list) ~= 'table' then list = {} end

    -- most recent goes last (that's the order the dashboard reads)
    list = vim.tbl_filter(function(p) return p ~= root end, list)
    table.insert(list, root)
    if #list > 20 then list = vim.list_slice(list, #list - 19) end

    vim.fn.mkdir(vim.fs.dirname(path), 'p')
    vim.fn.writefile(vim.split('return ' .. vim.inspect(list), '\n'), path)
  end,
})
