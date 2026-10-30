# Neovim config

Personal Neovim config. Plugins are managed with the built-in `vim.pack` (Neovim 0.12+), not lazy.nvim or packer.

## Layout

- `init.lua` — sets leader (`<Space>`), loads `config.*`, then requires each plugin module. Plugins load in the order listed there.
- `lua/config/options.lua` — editor options (2-space indent, expandtab).
- `lua/config/keymaps.lua` — general keymaps, using `local map = vim.keymap.set` with a `desc` on each.
- `lua/plugins/<name>.lua` — one file per feature area. Each calls `vim.pack.add({...})` at the top, then `require('<plugin>').setup({...})`.
- `nvim-pack-lock.json` — plugin lockfile written by `vim.pack`; commit it with plugin changes, don't hand-edit.

## Plugins

| File | Plugins |
| --- | --- |
| `completion.lua` | blink.cmp (`super-tab` preset: Tab accepts), friendly-snippets |
| `lsp.lua` | nvim-lspconfig, mason, mason-lspconfig — servers in `ensure_installed`, per-server settings via `vim.lsp.config()` before enabling |
| `formatting.lua` | conform.nvim — prettierd/prettier for web files, goimports for Go |
| `telescope.lua`, `treesitter.lua`, `git.lua`, `statusline.lua`, `colorscheme.lua` | as named |

## Conventions

- Adding a plugin: put it in the matching `lua/plugins/*.lua` file, or create a new one and add a `require("plugins.<name>")` line to `init.lua`.
- Pin plugin versions with `version = vim.version.range('^N')` where the plugin uses semver tags.
- Keep short trailing comments explaining non-obvious settings, matching existing files.
- Commit messages use conventional prefixes (`feat:`, `fix:`).

## Verifying changes

Check that the config loads without errors:

```sh
nvim --headless -c 'qa' 2>&1
```

Inspect a resolved setting, e.g. blink.cmp's keymap:

```sh
nvim --headless -c 'lua print(vim.inspect(require("blink.cmp.config").keymap))' -c 'qa'
```
