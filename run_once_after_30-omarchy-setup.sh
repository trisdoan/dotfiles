#!/bin/bash
set -euo pipefail

# retro-82 is a stock Omarchy theme, no `omarchy theme install` needed.
omarchy theme set retro-82
omarchy font set "Fira Code"
omarchy bar transparent true

# The only other local deviation from the packaged shell.json. `put` leaves a
# widget that is already on the bar where it is, so this is idempotent; it
# needs omarchy-shell running, which it is not during a headless first apply.
omarchy bar put omarchy.tailscale right || true

# Native Zen from the AUR (zen-browser-bin), plus the XDG default so
# omarchy-launch-browser and the stock SUPER+SHIFT+B binding both use it.
omarchy install browser zen
omarchy default browser zen
