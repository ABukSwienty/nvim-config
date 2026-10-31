vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
})

vim.cmd.colorscheme("tokyonight-night")

-- Distinct background for terminal windows
local function set_term_hl()
	local bg = "#000000"
	vim.api.nvim_set_hl(0, "TermNormal", { bg = bg })
	-- winbar label: keep Title's colour, but on the terminal background
	local title = vim.api.nvim_get_hl(0, { name = "Title", link = false })
	vim.api.nvim_set_hl(0, "TermTitle", { fg = title.fg, bg = bg, bold = true })
	-- window separators (global: a separator belongs to the window beside it, not the terminal)
	-- dark grey line on the editor background (tokyonight's gutter grey)
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3b4261" })
end
set_term_hl()
-- Re-apply after any colorscheme change (colorschemes reset highlights)
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_term_hl })

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		-- darker background for the whole window: body, unfocused body, winbar, filler rows
		vim.wo.winhighlight =
			"Normal:TermNormal,NormalNC:TermNormal,WinBar:TermNormal,WinBarNC:TermNormal,EndOfBuffer:TermNormal"
		vim.wo.signcolumn = "no"
		vim.wo.winbar = "%#TermTitle# TERMINAL" -- label at the top of the window
	end,
})
