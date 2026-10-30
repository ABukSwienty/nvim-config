-- Leader must be set before any mapping is defined
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")

-- Plugins: load order = order listed here
require("plugins.colorscheme")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.completion")
require("plugins.lsp")
require("plugins.formatting")
require("plugins.git")
