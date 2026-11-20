vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap", version = vim.version.range("^0.10") },
	{ src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("^1") },
	"https://github.com/leoluz/nvim-dap-go",
})

local dap = require("dap")

-- Install debug adapters via Mason on first run (Mason is set up in lsp.lua)
local registry = require("mason-registry")
registry.refresh(function()
	for _, name in ipairs({ "js-debug-adapter", "delve" }) do
		local pkg = registry.get_package(name)
		if not pkg:is_installed() then
			pkg:install()
		end
	end
end)

require("dap-view").setup({
	auto_toggle = "keep_terminal", -- open panel on start; on end close it but keep program output
	virtual_text = { enabled = true, position = "eol" }, -- `x = 42` at end of line while paused
})

-- TS/JS: run under Node (24+ runs .ts directly) via VS Code's js-debug
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = { command = "js-debug-adapter", args = { "${port}" } },
}

-- Plain Node only strips types; this also compiles enums, namespaces and
-- `constructor(private x)` (the warning just says the flag is experimental)
local node_flags = { "--experimental-transform-types", "--disable-warning=ExperimentalWarning" }

local node = {
	type = "pwa-node",
	runtimeArgs = node_flags,
	cwd = "${workspaceFolder}",
	skipFiles = { "<node_internals>/**" }, -- step into your code, not Node's
	console = "integratedTerminal", -- output in a terminal pane that stays after exit
	request = "launch",
}
for _, ft in ipairs({ "typescript", "javascript" }) do
	dap.configurations[ft] = {
		vim.tbl_extend("force", node, { name = "Step through file (pause on line 1)", program = "${file}", stopOnEntry = true }),
		vim.tbl_extend("force", node, { name = "Run file (stops at breakpoints)", program = "${file}" }),
		-- Like `node file.ts < input`; can't pause on line 1, so set a breakpoint first
		vim.tbl_extend("force", node, {
			name = "Run file with piped input (stops at breakpoints)",
			runtimeExecutable = "sh", -- js-debug still attaches to the node it starts
			runtimeArgs = function()
				local input = vim.fn.input({ prompt = "Input file: ", completion = "file" })
				local cmd = "node " .. table.concat(node_flags, " ") .. " " .. vim.fn.shellescape(vim.fn.expand("%:p")) .. " < " .. vim.fn.shellescape(vim.fn.expand(input))
				return { "-c", cmd }
			end,
		}),
	}
end

-- Go: delve, with "debug test under cursor"
require("dap-go").setup()

local set = function(mode, keys, fn, desc)
	vim.keymap.set(mode, keys, fn, { desc = desc })
end

set("n", "<leader>ds", dap.continue, "Debug: start / continue")
set("n", "<leader>db", dap.toggle_breakpoint, "Debug: toggle breakpoint")
set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, "Debug: conditional breakpoint")
set("n", "<leader>dc", dap.run_to_cursor, "Debug: run to cursor")
set({ "n", "x" }, "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, "Debug: hover value")
set("n", "<leader>dl", dap.run_last, "Debug: rerun last")
set("n", "<leader>dq", function()
	if dap.session() then
		dap.terminate()
	else
		require("dap-view").close(true) -- nothing running: close leftover output pane
	end
end, "Debug: stop / close output")
set("n", "<leader>dv", "<cmd>DapViewToggle<CR>", "Debug: toggle panel")
set("n", "<leader>dt", function()
	require("dap-go").debug_test()
end, "Debug: Go test under cursor")

-- Arrows step only while a session runs; their previous mappings (multicursor
-- Up/Down) are saved and restored when the last session ends
local step_keys = {
	["<Right>"] = { dap.step_over, "Debug: step over" },
	["<Down>"] = { dap.step_into, "Debug: step into" },
	["<Up>"] = { dap.step_out, "Debug: step out" },
	["<Left>"] = { dap.continue, "Debug: continue" },
}
local saved
dap.listeners.on_session["arrow-step-keys"] = function(_, new)
	if new and not saved then
		saved = {}
		for key, map in pairs(step_keys) do
			saved[key] = vim.fn.maparg(key, "n", false, true)
			set("n", key, map[1], map[2])
		end
	elseif not new and saved then
		for key, old in pairs(saved) do
			if next(old) then
				vim.fn.mapset(old)
			else
				vim.keymap.del("n", key)
			end
		end
		saved = nil
	end
end
