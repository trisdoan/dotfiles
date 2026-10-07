#!/bin/bash
set -euo pipefail

command -v omarchy-plugin-add >/dev/null || exit 0

omarchy plugin list | grep -q '^io.github.sirjul1337.lock-explorer ' ||
  omarchy plugin add https://github.com/SirJul1337/omarchy-lock-explorer.git --enable --yes
