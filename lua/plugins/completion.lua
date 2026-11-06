vim.pack.add({
	"https://github.com/rafamadriz/friendly-snippets", -- snippet collection (TS, Go, HTML, ...)
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("blink.cmp").setup({
	keymap = { preset = "default" }, -- <C-y> accepts, <Tab>/<S-Tab> jump between snippet fields

	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 300 }, -- docs next to the menu
	},

	signature = { enabled = true }, -- function parameter hints while typing arguments

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lsp = {
				-- Tailwind's classRegex treats every string inside clsx()/cn() as classes,
				-- so rank its items below TS (e.g. variant unions in clsx({ ... }))
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						if item.client_name == "tailwindcss" then
							item.score_offset = (item.score_offset or 0) - 10
						end
					end
					return items
				end,
			},
		},
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },
})
