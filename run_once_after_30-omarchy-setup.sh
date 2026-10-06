#!/bin/bash
set -euo pipefail

omarchy theme set retro-82
omarchy theme bg set "$(omarchy theme dir retro-82)/backgrounds/5-zen-boat.jpg"
omarchy bar transparent true
omarchy plymouth set by theme retro-82

# omarchy-launch-browser and the stock SUPER+SHIFT+B binding both use it.
omarchy install browser zen
omarchy default browser zen
