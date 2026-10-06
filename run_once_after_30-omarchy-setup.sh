#!/bin/bash
set -euo pipefail

omarchy theme set retro-82
omarchy theme bg set "$(omarchy theme dir retro-82)/backgrounds/5-zen-boat.jpg"
omarchy bar transparent true
# bypass `omarchy plymouth set by theme`, which hardcodes the theme's own
# unlock.png as the logo; pull just its bg/fg colors and pair them with our
# own logo instead.
plymouth_theme_dir=$(omarchy theme dir retro-82)
plymouth_bg=$(grep -m1 '^background' "$plymouth_theme_dir/colors.toml" | cut -d'"' -f2)
plymouth_fg=$(grep -m1 '^foreground' "$plymouth_theme_dir/colors.toml" | cut -d'"' -f2)
omarchy plymouth set "$plymouth_bg" "$plymouth_fg" ~/.config/plymouth/tris-doan-logo.png
omarchy font set "JetBrainsMono Nerd Font"

# omarchy-launch-browser and the stock SUPER+SHIFT+B binding both use it.
omarchy install browser zen
omarchy default browser zen
