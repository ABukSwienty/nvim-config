vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
})

vim.cmd.colorscheme("tokyonight-night")

-- Distinct background for terminal windows
local function set_term_hl()
	vim.api.nvim_set_hl(0, "TermNormal", { bg = "#16161e" }) -- darker than tokyonight-night bg (#1a1b26)
end
set_term_hl()
-- Re-apply after any colorscheme change (colorschemes reset highlights)
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_term_hl })

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.wo.winhighlight = "Normal:TermNormal" -- use the darker background in this window
		vim.wo.signcolumn = "no"
		vim.wo.winbar = "%#Title# TERMINAL" -- label at the top of the window
	end,
})
