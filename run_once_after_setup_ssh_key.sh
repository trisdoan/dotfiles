#!/bin/bash

set -e

KEY_NAME="id_ed25519"
KEY_PATH="$HOME/.ssh/$KEY_NAME"
EMAIL="doanminhtri8183@gmail.com"

# # 1. Generate SSH key if not present
# if [[ ! -f "$KEY_PATH" ]]; then
#   echo "🔑 Generating SSH key..."
#   ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
# fi
#
# # 2. Add to ssh-agent
# eval "$(ssh-agent -s)"
# ssh-add "$KEY_PATH"
#
# # 3. Upload to GitHub via gh CLI if not already uploaded
# KEY_TITLE="$(hostname)-$(date +%Y-%m-%d)"
# PUB_KEY_CONTENT=$(cat "${KEY_PATH}.pub")
#
# # Check if key already exists on GitHub
# if ! gh ssh-key list | grep -q "$PUB_KEY_CONTENT"; then
#   echo "☁️  Uploading SSH key to GitHub..."
#   echo "$PUB_KEY_CONTENT" | gh ssh-key add -t "$KEY_TITLE"
# else
#   echo "✅ SSH key already uploaded to GitHub."
# fi
