#!/bin/sh
# CLI tools required by dot_bashrc / dot_config/bash/*.
# run_onchange_: chezmoi re-runs this only when the formula list below changes.
# formulas: bash bash-completion@2 eza bat starship zoxide fzf

set -eu

[ "$(uname -s)" = "Darwin" ] || exit 0
command -v brew >/dev/null 2>&1 || {
	echo "brew not found; skipping CLI tool install" >&2
	exit 0
}

for formula in bash bash-completion@2 eza bat starship zoxide fzf; do
	brew list --formula "$formula" >/dev/null 2>&1 || brew install "$formula"
done
