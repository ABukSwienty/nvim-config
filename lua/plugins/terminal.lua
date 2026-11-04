vim.pack.add({
  { src = 'https://github.com/folke/snacks.nvim', version = vim.version.range('^2') },
  { src = 'https://github.com/coder/claudecode.nvim', version = vim.version.range('^0.3') }, -- '^0' would mean 0.0.x only
})

-- Only snacks' terminal is used; its other modules stay off unless enabled here.
-- Snacks windows set their options per window (and hide gutter/cursorline by default),
-- so the terminal look doesn't leak into other windows.
require('snacks').setup({
  styles = {
    terminal = {
      wo = {
        -- darker background for the whole window: body, unfocused body, winbar, filler rows
        winhighlight = 'Normal:TermNormal,NormalNC:TermNormal,WinBar:TermNormal,WinBarNC:TermNormal,EndOfBuffer:TermNormal',
        winbar = '%#TermTitle# TERMINAL', -- label at the top of the window
      },
    },
  },
})

require('claudecode').setup({
  terminal = {
    provider = 'snacks',
    split_side = 'right',          -- full-height column on the far right
    split_width_percentage = 0.4,
    snacks_win_opts = { wo = { winbar = '%#TermTitle# CLAUDE' } },
  },
})

local map = vim.keymap.set

-- Main terminal (bottom). A count opens a separate one: 2<leader>tt
-- (in terminal mode, double Esc goes to normal mode)
map('n', '<leader>tt', function() Snacks.terminal.toggle() end, { desc = 'Toggle terminal' })

-- Floating terminal. Passing the shell as cmd gives it its own terminal id,
-- otherwise it would toggle the bottom one.
map('n', '<leader>tf', function()
  Snacks.terminal.toggle(vim.o.shell, { win = { position = 'float' } })
end, { desc = 'Floating terminal' })

-- All terminals at once
map('n', '<leader>ta', function()
  for _, term in ipairs(Snacks.terminal.list()) do term:toggle() end
end, { desc = 'Toggle all terminals' })

-- Claude Code (right side; hiding keeps the session running)
map('n', '<leader>tc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
map('x', '<leader>as', '<cmd>ClaudeCodeSend<CR>', { desc = 'Send selection to Claude' })
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<CR>', { desc = 'Add buffer to Claude context' })
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<CR>', { desc = 'Accept Claude diff' })
map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<CR>', { desc = 'Reject Claude diff' })
