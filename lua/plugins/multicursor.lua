vim.pack.add({
	{ src = "https://github.com/jake-stewart/multicursor.nvim", version = "1.0" }, -- stable branch, no semver tags
})

local mc = require("multicursor-nvim")
mc.setup()

local set = function(mode, keys, fn, desc)
	vim.keymap.set(mode, keys, fn, { desc = desc })
end

-- Add/skip cursor above/below the main cursor
set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end, "Add cursor above")
set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end, "Add cursor below")
set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end, "Skip cursor above")
set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end, "Skip cursor below")

-- Add/skip cursor at next/prev match of word or selection
set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end, "Add cursor at next match")
set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end, "Skip next match")
set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end, "Add cursor at prev match")
set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end, "Skip prev match")
set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors, "Add cursors at all matches")

-- Ctrl+click to add/remove cursors
set("n", "<c-leftmouse>", mc.handleMouse, "Toggle cursor at click")
set("n", "<c-leftdrag>", mc.handleMouseDrag, "Drag cursor")
set("n", "<c-leftrelease>", mc.handleMouseRelease, "Release cursor drag")

-- Disable cursors to move the main one alone, then re-enable
set({ "n", "x" }, "<c-q>", mc.toggleCursor, "Toggle multicursor")

set("n", "<leader>gv", mc.restoreCursors, "Restore cleared cursors")
set({ "n", "x" }, "<leader>a", mc.alignCursors, "Align cursors")
set("x", "S", mc.splitCursors, "Split selection into cursors by regex")
set("x", "M", mc.matchCursors, "Add cursors at regex matches in selection")
set("x", "I", mc.insertVisual, "Insert at start of each selected line")
set("x", "A", mc.appendVisual, "Append at end of each selected line")
set({ "n", "x" }, "ga", mc.addCursorOperator, "Add cursors over motion")
set("x", "<leader>t", function() mc.transposeCursors(1) end, "Rotate selections forward")
set("x", "<leader>T", function() mc.transposeCursors(-1) end, "Rotate selections backward")

-- Only active while multiple cursors exist
mc.addKeymapLayer(function(layerSet)
	layerSet({ "n", "x" }, "<left>", mc.prevCursor)
	layerSet({ "n", "x" }, "<right>", mc.nextCursor)
	layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
	layerSet("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		else
			mc.clearCursors()
		end
	end)
end)
