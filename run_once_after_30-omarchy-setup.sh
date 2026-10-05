#!/bin/bash
set -euo pipefail

# flexoki-dark is not a stock theme (only flexoki-light is), so install the
# git theme once. `omarchy theme update` refreshes it later.
omarchy theme extras | grep -q 'themes/flexoki-dark$' ||
  omarchy theme install https://github.com/euandeas/omarchy-flexoki-dark-theme.git

omarchy theme set flexoki-dark
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
