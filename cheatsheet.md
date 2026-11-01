# Neovim cheat sheet (this config)

Search this file: `/text` then `Enter`, `n` / `N` for next / previous match.

Leader = Space. `Space f k` searches all keymaps.

## Modes
| Keys | Action |
|---|---|
| `i` / `a` | Insert before / after cursor |
| `o` / `O` | New line below / above |
| `v` / `V` / `Ctrl-v` | Visual: chars / lines / block |
| `Esc` | Back to normal mode (also clears search highlight) |

## Files and saving
| Keys | Action |
|---|---|
| `Space w` / `Space q` | Save / quit window |
| `:noa w` | Save without formatting |
| `-` / `_` | Explorer (oil) at file dir / at cwd |
| `Space o` | Explorer (oil) floating |
| oil: edit text + `:w` | Rename, create (`name/` = dir), delete (`dd`), move |
| oil: `` ` `` | Make shown dir the cwd |
| oil: `o` name `Esc` `:w` | New file (`name/` = dir, `dir/file.ts` = both) |
| oil: `Ctrl-s` / `Ctrl-h` / `Ctrl-t` | Open in right split / split below / new tab |
| oil: `Ctrl-p` | Preview file |
| oil: `g.` / `g?` | Toggle hidden files / show all keys |
| `Space ?` | Open this cheat sheet (`q` saves and closes) |
| `Space t m` | Toggle markdown rendering |

## Telescope (find)
| Keys | Action |
|---|---|
| `Space f f` | Find file |
| `Space f g` | Grep project |
| `Space f b` | Open buffers (incl. terminals) |
| `Space f r` | Recent files |
| `Space f k` | Search all keymaps |
| `Space f h` | Search help |
| `Space f d` | Diagnostics |
| `Space f s` / `Space f S` | Symbols in file / project |
| In picker: `Ctrl-q` | Send results to quickfix |
| In picker: `Ctrl-v` / `Ctrl-x` | Open in vsplit / split |

## Movement
| Keys | Action |
|---|---|
| `h j k l` | Left down up right |
| `w` / `b` / `e` | Next word / back / end of word |
| `0` / `^` / `$` | Line start / first char / line end |
| `gg` / `G` / `42G` | First line / last line / line 42 |
| `Ctrl-d` / `Ctrl-u` | Half page down / up |
| `%` | Matching bracket |
| `Ctrl-o` / `Ctrl-i` | Jump back / forward |
| `zz` | Center cursor line |

## Editing
| Keys | Action |
|---|---|
| `x` / `dd` / `D` | Delete char / line / to end of line |
| `cw` / `cc` / `C` | Change word / line / to end of line |
| `yy` / `p` / `P` | Copy line / paste after / before |
| `u` / `Ctrl-r` | Undo / redo |
| `.` | Repeat last change |
| `>>` / `<<` | Indent / dedent |
| `ci{` `di(` `yi"` `vit` | Change/delete/yank/select inside `{}` `()` `""` tag |
| `J` / `K` (visual) | Move selection down / up |
| `]e` / `[e` | Move line down / up |

## Search and replace
| Keys | Action |
|---|---|
| `/text` `n` `N` | Search, next, previous |
| `*` / `#` | Search word under cursor |
| `:%s/old/new/g` | Replace in file (`gc` = confirm) |
| `:%s/\<old\>/new/g` | Whole word only |
| `:cdo s/old/new/g \| update` | Replace in all quickfix entries |
| `:%s/a.\{-}b//g` | Non-greedy match (stops at first `b`; `.*` stops at last) |
| `:%s/<C-r><C-w>/new/g` | Replace word under cursor (`Ctrl-r Ctrl-w` inserts it) |
| Project-wide | `Space f g` → `Ctrl-q` → `:cdo s/old/new/g \| update` |

## Multi-edit (built-in)
| Keys | Action |
|---|---|
| `*` then `cgn` new `Esc` | Change next match of word under cursor |
| `.` / `n` | Repeat on next match / skip match |
| `Ctrl-v` `j..` `I` text `Esc` | Insert text at the same column on several lines |
| `Ctrl-v` `j..` `$A` text `Esc` | Append text to the end of several lines |
| `Ctrl-v` `j..` `d` | Delete a rectangular block |
| Example | `:%s/ className={styles\..\{-}}//g` = remove all `className={styles.x}` |

## LSP
| Keys | Action |
|---|---|
| `K` | Hover docs |
| `gd` / `gD` | Definition / declaration |
| `grr` / `gri` / `grt` | References / implementation / type definition |
| `grn` | Rename symbol (project-wide) |
| `gra` | Code actions (imports, fixes) |
| `gO` | File outline |
| `]d` / `[d` | Next / previous diagnostic |
| `Space e` | Show diagnostic message |
| `Ctrl-s` / `Ctrl-k` (insert) | Signature help |

## Completion (insert mode)
| Keys | Action |
|---|---|
| `Tab` | Accept item / next snippet field |
| `Shift-Tab` | Previous snippet field |
| `Ctrl-n` / `Ctrl-p` | Next / previous item |
| `Ctrl-e` | Close menu |
| `Ctrl-Space` | Open menu / toggle docs |
| `Ctrl-f` / `Ctrl-b` | Scroll docs down / up |

## Formatting
| Keys | Action |
|---|---|
| (save) | Format on save |
| `Space c f` | Format file / selection |
| `=` (visual) / `gg=G` | Reindent selection / file |

## Git (gitsigns)
| Keys | Action |
|---|---|
| `]c` / `[c` | Next / previous hunk |
| `Space h p` | Preview hunk |
| `Space h s` / `Space h r` | Stage / reset hunk (or selected lines) |
| `Space h S` / `Space h R` | Stage / reset file |
| `Space h b` | Blame line |
| `Space t b` | Toggle inline blame |
| `Space h d` | Diff file |
| `dih` / `vih` | Delete / select hunk (text object) |

## Windows
| Keys | Action |
|---|---|
| `Ctrl-h/j/k/l` | Move between windows (also from terminals) |
| `:vsplit` / `:split` | Split window (same file) |
| `:vnew` / `:vsplit file` | Empty buffer / file in right split |
| `Ctrl-w =` | Equalize sizes |
| `Ctrl-w c` / `Ctrl-w o` | Close window / close all other windows |
| `Ctrl-^` | Previous buffer |

## Resize and move windows
| Keys | Action |
|---|---|
| Mouse drag on separator | Resize |
| `Ctrl-w +` / `Ctrl-w -` | Taller / shorter (count: `10 Ctrl-w +`) |
| `Ctrl-w >` / `Ctrl-w <` | Wider / narrower (count: `10 Ctrl-w >`) |
| `Ctrl-w _` / `Ctrl-w \|` | Maximize height / width |
| `:resize 20` / `:vertical resize 60` | Exact height / width |
| `Ctrl-w H` / `J` / `K` / `L` | Move window to far left / bottom / top / right |
| `Ctrl-w r` | Rotate windows in the row / column |
| `Ctrl-w x` | Swap with the next window |
| `Ctrl-w T` | Move window to a new tab |

## Terminals
| Keys | Action |
|---|---|
| `Space t t` | Toggle terminal (bottom) |
| `2 Space t t` | Toggle terminal number 2 |
| `Space t f` | Toggle floating terminal |
| `Space t c` | Toggle Claude Code (right) |
| `Space t a` | Toggle all terminals |
| `:TermSelect` | Pick a terminal |
| `Esc Esc` | Leave terminal mode |
| `Ctrl-d` | Exit shell |
| `:!cmd` | Run one shell command |

## Maintenance
| Command | Action |
|---|---|
| `:lua vim.pack.update()` | Update plugins (`:w` confirm, `:q` cancel) |
| `:Mason` then `U` | Update LSP servers / formatters |
| `:TSUpdate` | Update parsers |
| `:checkhealth` | Diagnose problems |
| `:restart` | Restart Neovim |
