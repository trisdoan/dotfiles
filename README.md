# dotfiles

chezmoi source tree for one machine: an Omarchy Linux box. Canonical checkout is
`~/projects/dotfiles`, set as `sourceDir` by `.chezmoi.toml.tmpl`, so plain
`chezmoi` commands work from anywhere.

## Rebuilding this machine

```bash
git clone git@github.com:trisdoan/dotfiles.git ~/projects/dotfiles
chezmoi init --source ~/projects/dotfiles
chezmoi apply -v
```

`run_once_before_10-packages.sh` installs packages first via `omarchy pkg add`;
`run_once_after_30-omarchy-setup.sh` then applies the theme, font, bar
transparency and default browser through Omarchy's own commands.

## What is managed

- bash (`.bashrc`, `.bash_profile`), git, neovim (LazyVim), ghostty, starship, mise
- Omarchy: `hypr/input.lua` (Esc<->CapsLock + Alt/Super swap) and `hypr/bindings.lua`

## What is deliberately Omarchy's, not ours

- **tmux** — Omarchy ships `~/.config/tmux/tmux.conf`. There is no personal tmux
  config. Restore it with `omarchy refresh tmux`, browse keys with
  `omarchy menu tmux keybindings`, and use the shipped session helpers
  `tdl` / `tds` / `tdlm` / `tsl` and `omarchy launch terminal tmux`
  (these replace tmuxifier).
- `hypr/hyprland.lua`, `hypr/monitors.lua`, `hypr/looknfeel.lua`,
  `hypr/autostart.lua` — left unmanaged so `omarchy refresh hyprland` and
  future migrations keep working.
- Theme, font, bar layout, default browser — set with `omarchy theme set`,
  `omarchy font set`, `omarchy bar …`, `omarchy default browser …`, not by
  tracking generated files.

## Day-to-day

```bash
chezmoi diff             # what would change in $HOME
chezmoi apply -v         # write changes to $HOME
chezmoi add <path>       # start tracking a live file
chezmoi cd               # -> ~/projects/dotfiles
```

`omarchy font set` edits `~/.config/ghostty/config` in place, so it shows up as
a `chezmoi diff` in the other direction. Re-add it
(`chezmoi add ~/.config/ghostty/config`) or revert with `chezmoi apply`.
