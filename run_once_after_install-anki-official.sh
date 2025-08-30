#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Anki Dependencies for Arch Linux ---
echo "› Installing Anki dependencies for Arch Linux..."
# '--noconfirm' prevents prompts and '--needed' skips packages that are already up to date.
sudo pacman -S --noconfirm --needed libxcb nss

ANKI_URL="https://github.com/ankitects/anki/releases/download/25.07.5/anki-launcher-25.07.5-linux.tar.zst"
ANKI_PKG_NAME="anki-launcher-25.07.5-linux"

# Create a temporary directory for the download and extraction
ANKI_TMP_DIR=$(mktemp -d)
# Ensure the temp directory is cleaned up on script exit
trap 'rm -rf -- "$ANKI_TMP_DIR"' EXIT

echo "  › Downloading Anki..."
curl -L -o "$ANKI_TMP_DIR/anki.tar.zst" "$ANKI_URL"

echo "  › Extracting archive..."
tar -xaf "$ANKI_TMP_DIR/anki.tar.zst" -C "$ANKI_TMP_DIR"

echo "  › Running Anki installer..."
(
  cd "$ANKI_TMP_DIR/$ANKI_PKG_NAME"
  sudo ./install.sh
)

echo "✅ Anki official installation complete!"
