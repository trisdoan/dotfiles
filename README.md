# dotfiles

chezmoi config for one machine: Omarchy Linux.
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

## Customization

- Esc<->CapsLock + Left Alt<->Super swap (replaces Omarchy's compose-key default)
- Slack on `SUPER+SHIFT+S` (replaces default Google Maps webapp)
- Screenshots/recording on F8 (not PrintScreen): `F8` region, `SHIFT+F8` window, `ALT+F8` record, `CTRL+ALT+F8` record display
- `ALT+F/H/J/K/L` window fullscreen/focus
- ghostty: font Fira Code, ligatures (ss02/03/05/07), opacity 0.8, 1B scrollback, `SUPER+Z` split zoom
- bash: git/docker/agent aliases, guarded PATH additions
- git: delta pager, `fixup` alias
- neovim: LazyVim + AI/coding/formatting/lsp/mason/noice/snacks/surround, no tmux-navigator
- theme `retro-82`, font `Fira Code`, transparent bar, tailscale widget

## Commands

```bash
chezmoi diff        # preview changes
chezmoi apply -v    # apply changes
chezmoi add <path>  # track a new file
chezmoi cd          # go to source dir
```
