vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local map = function(mode, keys, fn, desc)
			vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = desc })
		end

		-- Navigation (falls back to built-in ]c/[c inside diff views)
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next hunk")
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Previous hunk")

		-- Hunk actions
		map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
		map("n", "<leader>hs", gs.stage_hunk, "Stage / unstage hunk")
		map("n", "<leader>hr", gs.reset_hunk, "Reset hunk (discard change)")
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage selected lines")
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset selected lines")

		-- Buffer actions
		map("n", "<leader>hS", gs.stage_buffer, "Stage file")
		map("n", "<leader>hR", gs.reset_buffer, "Reset file")
		map("n", "<leader>hd", gs.diffthis, "Diff file against index")

		-- Blame
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, "Blame line")
		map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle inline blame")

		-- Text object: `ih` = inside hunk (e.g. `dih` deletes the hunk, `vih` selects it)
		map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
	end,
})
