# Keybindings (macOS)

Reference for this branch's three keyboard layers: **AeroSpace** (window manager, `alt`),
**Ghostty** (terminal, `cmd`) and **bash/readline** (the shell itself). Regenerate the live
truth with:

```sh
aerospace config --get mode.main.binding --keys   # every bound AeroSpace key
ghostty +list-keybinds                            # Ghostty defaults + overrides
bind -p; bind -X                                  # readline keys + fzf widgets
```

## Zoom / fullscreen a window — `alt+shift+enter`

Added deliberately; it is the answer to "I have two terminals tiled, how do I make one big?"

```toml
# dot_config/aerospace/aerospace.toml
alt-shift-enter = 'fullscreen'
```

- Toggle. Press again to return to the tiled layout.
- Runs AeroSpace's **own** fullscreen, **not** native macOS fullscreen. Native fullscreen
  creates an extra macOS Space, and AeroSpace supports exactly one Space per monitor —
  extra Spaces silently desync the tiler.
- Verified: focused window `750x939` -> `1500x940` (full display) -> `750x939`.
- Why not `alt+shift+f` (AeroSpace's stock default): this config reassigns every
  `alt-<letter>` and `alt-shift-<letter>` to workspace switch / move-to-workspace,
  so `alt+shift+f` means "move window to workspace F".
- `cmd+z` (`toggle_split_zoom`) does **not** do this. It only zooms a split *inside* one
  Ghostty window; two separate windows have no split to zoom.
- Softer alternative, already bound: `alt+,` switches to accordion layout — focused window
  takes the space, siblings collapse to a 30px strip (`accordion-padding = 30`).
  `alt+/` returns to tiles.

## AeroSpace — main mode

| Keys | Action |
|---|---|
| `alt+enter` | Launch / focus Ghostty (`open -a Ghostty`) |
| `alt+shift+enter` | **Fullscreen toggle for focused window** |
| `alt+/` | Layout tiles (horizontal / vertical) |
| `alt+,` | Layout accordion (horizontal / vertical) |
| `alt+h/j/k/l` | Focus left / down / up / right |
| `alt+shift+h/j/k/l` | Move window left / down / up / right |
| `alt+-` / `alt+=` | Resize focused window by -50 / +50 |
| `alt+1`..`alt+9`, `alt+<letter>` | Switch to that workspace |
| `alt+shift+1`..`9`, `alt+shift+<letter>` | Move window to that workspace **and follow it** |
| `alt+tab` | Workspace back-and-forth |
| `alt+shift+tab` | Move current workspace to next monitor (wraps) |
| `alt+shift+;` | Enter *service* mode |

### Service mode (after `alt+shift+;`)

| Key | Action |
|---|---|
| `esc` | Reload config, back to main mode |
| `r` | Flatten workspace tree (reset layout) |
| `f` | Toggle floating / tiling for focused window |
| `backspace` | Close all windows except the focused one |

Free keys left in main mode: `alt+shift+` + `/`, `,`, `.`, `-`, `=`.
Everything else is taken — 79 bindings.

`auto-reload-config = true`, so edits to `aerospace.toml` apply on save. No restart, no
`aerospace reload-config`. (This was previously `false`, which caused a stale server to
silently ignore `alt+shift+2`.)

## Ghostty

Overrides set in `dot_config/ghostty/config`:

| Keys | Action | Note |
|---|---|---|
| `cmd+enter` | `new_window` | Ghostty's default here was `toggle_fullscreen` (native → extra Space → breaks AeroSpace) |
| `cmd+z` | `toggle_split_zoom` | Zooms a split pane, not a window |
| `shift+enter` | send `ESC CR` (`\x1b\r`) | Multiline submit in TUIs / REPLs |

Useful defaults (not set by us, they just exist):

| Keys | Action |
|---|---|
| `cmd+n` / `cmd+t` / `cmd+w` | New window / new tab / close surface |
| `cmd+d` / `cmd+shift+d` | Split right / split down |
| `cmd+[` / `cmd+]` | Previous / next split |
| `cmd+alt+arrows` | Focus split by direction |
| `cmd+ctrl+=` | Equalize splits |
| `cmd+shift+enter` | Toggle split zoom |
| `cmd+1`..`cmd+8` | Go to tab N |
| `cmd+shift+[` / `cmd+shift+]` | Previous / next tab |
| `cmd+arrow_up` / `cmd+arrow_down` | Jump to previous / next shell prompt |
| `cmd+f` | Search scrollback |
| `cmd+k` | Clear screen |
| `cmd+shift+,` | Reload Ghostty config (needed — no auto-reload) |
| `cmd+alt+i` | Toggle inspector |

Unbound on purpose: `toggle_quick_terminal`. The `quick-terminal-position` /
`quick-terminal-animation-duration` settings in the config are therefore inert; add e.g.
`keybind = global:ctrl+grave_accent=toggle_quick_terminal` to activate the drop-down
terminal. Avoid `cmd+grave_accent` — macOS owns it ("move focus to next window").

## Bash + readline

Shell config is `~/.bashrc` -> `~/.config/bash/{envs,shell,aliases,functions,init}` with
readline in `~/.inputrc` (all chezmoi-managed, modelled on omarchy's `default/bash/*`).

| Keys | Action |
|---|---|
| `up` / `down` | History search on what you already typed (`history-search-backward/forward`), not a blind history walk |
| `tab` / `shift+tab` | Cycle completion candidates (`menu-complete` / `menu-complete-backward`) |
| `ctrl+r` | fzf fuzzy history (`__fzf_history__`) |
| `ctrl+t` | fzf file picker, inserts the path at the cursor (`fzf-file-widget`) |
| `**` + `tab` | fzf completion trigger for any command — `vi src/**<tab>`, `kill **<tab>`, `ssh **<tab>` |
| `ctrl+w` / `ctrl+u` / `ctrl+k` / `ctrl+a` / `ctrl+e` | readline defaults (kill word / to line start / to line end, jump to start / end) |

Completion is case-insensitive, ambiguous matches list immediately, and the common prefix
is inserted before cycling (`completion-ignore-case`, `show-all-if-ambiguous`,
`menu-complete-display-prefix`). Every keybinding in `.inputrc` sits inside `$if Bash`, so
`python`, `psql` and other readline programs keep their stock behaviour.

**`alt+c` (fzf cd widget) is unreachable.** fzf binds it (`"\ec"` macro -> `__fzf_cd__`),
but AeroSpace claims every `alt-<letter>` before Ghostty sees it and `macos-option-as-alt`
is unset. Use `cd **<tab>` or just `cd <partial-name>` — `cd` is zoxide (`zd`), so a
frecency jump replaces the widget.

### Aliases and functions

| Command | Meaning |
|---|---|
| `ls` / `lsa` / `lt` / `lta` | `eza -lh` / `+ -a` / tree depth 2 with git / tree with hidden |
| `..` / `...` / `....` | Up 1 / 2 / 3 directories |
| `cd <name>` | `zd` — real dir if it exists, else zoxide frecency jump (prints the target) |
| `ff` / `eff` | fzf with `bat` preview / open the pick in `$EDITOR` |
| `sff <dest>` | Pick a recent file by mtime, `scp` it to `<dest>` |
| `compress <dir>` / `decompress <file>` | `tar -czf dir.tar.gz` / `tar -xzf` |
| `cl` / `vi` / `lg` / `d` / `t` | `clear` / `nvim` / `lazygit` / `docker` / attach-or-create tmux session `Work` |
| `n [path]` | `nvim .` with no args, else `nvim <args>` |
| `cx` / `clb` | Claude with bypassed permissions / with the `~/.claude-backup` config dir |
| `g` / `gcm` / `gcam` / `gcad` | `git` / `commit -m` / `commit -a -m` / `commit -a --amend` |

The prompt is starship (`~/.config/starship.toml`): path, git branch, git status, and the
duration of anything slower than 2s, with `❯` on its own line. `cmd+arrow_up` /
`cmd+arrow_down` in Ghostty jump between those prompts.

## Layer interaction

AeroSpace grabs `alt` combos at the system level (Carbon hotkeys) before any app sees them,
and this config claims **every** `alt-<letter>` / `alt-shift-<letter>`. Consequence: `alt`
based shortcuts inside Ghostty, tmux, or nvim are mostly unreachable, which is why
`macos-option-as-alt` is left unset.
