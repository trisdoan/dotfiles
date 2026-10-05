# dotfiles

chezmoi config for one machine: Omarchy Linux. Source lives at
`~/projects/dotfiles`.

## Install

```bash
git clone git@github.com:trisdoan/dotfiles.git ~/projects/dotfiles
chezmoi init --source ~/projects/dotfiles
chezmoi apply -v
```

Installs packages, then sets theme/font/bar/browser via Omarchy commands.

## Managed

- bash, git, neovim (LazyVim), ghostty, starship, mise
- Hyprland: `hypr/input.lua` (Esc<->CapsLock swap), `hypr/bindings.lua`

## Not managed (Omarchy owns these)

- **tmux** — no personal config. Use Omarchy's `~/.config/tmux/tmux.conf`,
  restore with `omarchy refresh tmux`, sessions via `tdl` / `tds` / `tdlm` / `tsl`.
- `hypr/hyprland.lua`, `monitors.lua`, `looknfeel.lua`, `autostart.lua` —
  left alone so `omarchy refresh hyprland` keeps working.
- Theme, font, bar, browser, wallpaper — set live with `omarchy theme set`,
  `omarchy font set`, `omarchy bar`, `omarchy default browser`, not tracked.

## Commands

```bash
chezmoi diff        # preview changes
chezmoi apply -v    # apply changes
chezmoi add <path>  # track a new file
chezmoi cd          # go to source dir
```
