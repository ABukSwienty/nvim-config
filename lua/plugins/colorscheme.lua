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

-- Terminal look only in terminal windows. Window options are copied on :split and
-- stay when a window switches buffers, so undo the look once a non-terminal buffer shows.
-- opt_local, not vim.wo: vim.wo also sets the global value, which every new window inherits.
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter", "WinEnter" }, {
	callback = function()
		local wo = vim.opt_local
		if vim.bo.buftype == "terminal" then
			-- darker background for the whole window: body, unfocused body, winbar, filler rows
			wo.winhighlight =
				"Normal:TermNormal,NormalNC:TermNormal,WinBar:TermNormal,WinBarNC:TermNormal,EndOfBuffer:TermNormal"
			wo.signcolumn = "no"
			wo.winbar = "%#TermTitle# TERMINAL" -- label at the top of the window
		elseif vim.wo.winbar:find("TERMINAL") or vim.wo.winhighlight:find("Term") then -- only windows carrying the terminal look (also toggleterm's)
			wo.winhighlight = ""
			wo.winbar = ""
			-- back to the global values from options.lua (toggleterm/Claude turn these off)
			wo.signcolumn = vim.go.signcolumn
			wo.number = vim.go.number
			wo.relativenumber = vim.go.relativenumber
			wo.cursorline = vim.go.cursorline
		end
	end,
})
