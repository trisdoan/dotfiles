#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Simplenote AppImage Installation ---
echo "› Installing Simplenote AppImage..."

# URL for the Simplenote v2.23.2 AppImage
SIMPLENOTE_URL="https://github.com/Automattic/simplenote-electron/releases/download/v2.23.2/Simplenote-linux-2.23.2-x86_64.AppImage"
DOWNLOAD_PATH="/tmp/Simplenote.AppImage"

echo "  › Downloading Simplenote AppImage..."
curl -L -o "$DOWNLOAD_PATH" "$SIMPLENOTE_URL"

echo "  › Integrating with AppImageLauncher..."
# Use ail-cli to integrate the downloaded AppImage
ail-cli integrate "$DOWNLOAD_PATH"

# Clean up the downloaded file
rm "$DOWNLOAD_PATH"

echo "✅ Simplenote installation complete!"
