#!/bin/bash

set -euo pipefail

KEY_NAME="id_ed25519"
KEY_PATH="$HOME/.ssh/$KEY_NAME"
EMAIL="doanminhtri8183@gmail.com"

echo "──────────────────────────────────────────────"
echo "🔑 SSH Key Setup Instructions"
echo "──────────────────────────────────────────────"
echo ""
echo "1. Generate a new SSH key if it does not exist:"
echo "   ssh-keygen -t ed25519 -C \"$EMAIL\" -f \"$KEY_PATH\" -N \"\""
echo ""
echo "2. Start ssh-agent and add the key:"
echo "   eval \$(ssh-agent -s)"
echo "   ssh-add \"$KEY_PATH\""
echo ""
echo "3. Upload your public key to GitHub with the GitHub CLI:"
echo "   gh auth login"
echo "   gh auth refresh -h github.com -s admin:public_key"
echo "   gh ssh-key add \"${KEY_PATH}.pub\" --title \"\$(hostname)-\$(date +%Y-%m-%d)\""
echo ""
echo "4. Verify the key is added:"
echo "   gh ssh-key list"
echo ""
echo "✅ After completing these steps, you can use SSH with GitHub."
