vim.pack.add({ 'https://github.com/akinsho/toggleterm.nvim' })

require('toggleterm').setup({
  size = function(term)
    if term.direction == 'horizontal' then return 15 end
    if term.direction == 'vertical' then return math.floor(vim.o.columns * 0.4) end
  end,
  direction = 'horizontal',   -- default: bottom panel
  persist_size = true,
  shade_terminals = false,    -- background handled by the TermNormal highlight
  -- toggleterm sets its own winhighlight, overriding the TermOpen one in colorscheme.lua
  highlights = {
    Normal = { link = 'TermNormal' },
    NormalNC = { link = 'TermNormal' },
    NormalFloat = { link = 'TermNormal' },
    WinBar = { link = 'TermNormal' },
    WinBarNC = { link = 'TermNormal' },
    EndOfBuffer = { link = 'TermNormal' },
  },
  float_opts = { border = 'rounded' },
  -- runs on every open (TermOpen only fires once), so re-opened splits don't
  -- inherit number/sign columns and cursorline from the previous window
  on_open = function(term)
    local wo = vim.wo[term.window]
    wo.number = false
    wo.relativenumber = false
    wo.signcolumn = 'no'
    wo.cursorline = false
  end,
})

local map = vim.keymap.set

-- Main terminal (bottom): Space t t (from terminal mode, Esc Esc first)
map('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })

-- Floating terminal (never replaces a window)
map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Floating terminal' })

-- Claude Code (right side, persistent).
-- Not a toggleterm Terminal: toggleterm stacks new terminals into an already-open
-- terminal panel, so it would land in the bottom panel instead of on the right.
local claude_buf, claude_win
local function toggle_claude()
  if claude_win and vim.api.nvim_win_is_valid(claude_win) then
    vim.api.nvim_win_hide(claude_win)  -- hide, keep the session running
    claude_win = nil
    return
  end
  vim.cmd('botright vsplit')           -- full-height column on the far right
  claude_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(claude_win, math.floor(vim.o.columns * 0.4))
  local wo = vim.wo[claude_win]        -- vsplit copies the previous window's gutter options
  wo.number, wo.relativenumber, wo.signcolumn, wo.cursorline = false, false, 'no', false
  if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
    vim.api.nvim_win_set_buf(claude_win, claude_buf)
  else
    vim.cmd('enew')
    vim.fn.jobstart({ 'claude' }, {
      term = true,
      on_exit = function()             -- next toggle starts a fresh session
        vim.schedule(function()
          if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
            vim.api.nvim_buf_delete(claude_buf, { force = true })
          end
          claude_buf = nil
        end)
      end,
    })
    claude_buf = vim.api.nvim_get_current_buf()
    vim.bo[claude_buf].bufhidden = 'hide'
  end
  vim.cmd('startinsert')
end
map('n', '<leader>tc', toggle_claude, { desc = 'Toggle Claude Code' })

-- All terminals at once
map('n', '<leader>ta', '<cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle all terminals' })
