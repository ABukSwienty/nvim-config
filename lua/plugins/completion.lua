vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',  -- snippet collection (TS, Go, HTML, ...)
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('^1') },
})

require('blink.cmp').setup({
  keymap = { preset = 'super-tab' },  -- <Tab> accepts, <S-Tab> goes back in snippets

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 300 },  -- docs next to the menu
  },

  signature = { enabled = true },  -- function parameter hints while typing arguments

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lsp = {
        -- Rank TypeScript suggestions above Tailwind classes
        transform_items = function(_, items)
          for _, item in ipairs(items) do
            if item.client_name == 'ts_ls' then
              item.score_offset = (item.score_offset or 0) + 10
            end
          end
          return items
        end,
      },
    },
  },

  fuzzy = { implementation = 'prefer_rust_with_warning' },
})
