local opt = vim.opt

-- Display
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.scrolloff = 8
opt.breakindent = true     -- wrapped lines keep the line's indent (long Tailwind classes)
opt.breakindentopt = 'shift:2' -- ...plus 2 extra columns so continuations stand out
opt.linebreak = true       -- wrap at word boundaries, not mid-class
opt.showbreak = '↪ '

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.undofile = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Behavior
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 250
