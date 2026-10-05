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

## How to customize

1. Check if Omarchy has a command for it first (`omarchy commands --all`) —
   theme, font, bar, background, browser. Use that; never hand-edit a
   generated or dynamic file (e.g. the `config-file = ?"...theme/ghostty.conf"`
   include).
2. No command for it (keybinds, font size, aliases, padding, etc.) — edit the
   file in `~/projects/dotfiles`, then apply and reload:
   ```bash
   chezmoi apply -v ~/.config/ghostty/config
   omarchy restart terminal      # or: hyprctl reload, omarchy refresh tmux
   ```
3. Edited the live file instead? Pull it back into source before committing:
   ```bash
   chezmoi add ~/.config/ghostty/config
   ```

## Commands

```bash
chezmoi diff        # preview changes
chezmoi apply -v    # apply changes
chezmoi add <path>  # track a new file
chezmoi cd          # go to source dir
```
