vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons", -- file icons (also used by Telescope)
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	options = {
		theme = "tokyonight", -- matches the colorscheme
		globalstatus = true, -- one bar at the bottom instead of one per split
		icons_enabled = true, -- set to false without a Nerd Font
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } }, -- path relative to the project
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- Mode is shown in the bar; hide the duplicate "-- INSERT --" text
vim.opt.showmode = false
