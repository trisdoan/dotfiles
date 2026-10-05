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
- ghostty: opacity 0.8
- bash: git/docker/agent aliases, guarded PATH additions
- git: delta pager, `fixup` alias
- neovim: LazyVim + AI/coding/formatting/lsp/mason/noice/snacks/surround
- theme `retro-82`, transparent bar, tailscale widget

## Commands

```bash
chezmoi diff        # preview changes
chezmoi apply -v    # apply changes
chezmoi add <path>  # track a new file
chezmoi cd          # go to source dir
```
