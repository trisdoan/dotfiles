#!/usr/bin/env bash

DOTFILES_DIR="${DOTFILES_DIR:=${HOME}/dotfiles}"

echo "Installing software packages..."

if [ -f "${DOTFILES_DIR}/scripts/dnf-packages.txt" ]; then
  sudo dnf install -y $(cat "${DOTFILES_DIR}/scripts/dnf-packages.txt")
  echo "Software packages installed successfully"
else
  echo "Error: dnf-packages.txt not found in ${DOTFILES_DIR}/scripts/"
  exit 1
fi
