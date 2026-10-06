#!/bin/bash
set -euo pipefail

omarchy theme set retro-82
omarchy bar transparent true

# omarchy-launch-browser and the stock SUPER+SHIFT+B binding both use it.
omarchy install browser zen
omarchy default browser zen
