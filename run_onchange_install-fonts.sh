#!/bin/sh
# Fonts required by dot_config/ghostty/config.
# run_onchange_: chezmoi re-runs this only when the cask list below changes.
# casks: font-fira-code-nerd-font

set -eu

[ "$(uname -s)" = "Darwin" ] || exit 0
command -v brew >/dev/null 2>&1 || {
	echo "brew not found; skipping font install" >&2
	exit 0
}

for cask in font-fira-code-nerd-font; do
	brew list --cask "$cask" >/dev/null 2>&1 || brew install --cask "$cask"
done
