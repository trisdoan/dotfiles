#!/bin/bash

echo "🔧 Setting up fcitx5 input method profile..."

CONFIG_DIR="$HOME/.config/fcitx5"
PROFILE_FILE="$CONFIG_DIR/profile"

mkdir -p "$CONFIG_DIR"

cat > "$PROFILE_FILE" <<'EOF'
[Groups/0]
# Group Name
Name=Default
# Layout
Default Layout=us
# Default Input Method
DefaultIM=unikey

[Groups/0/Items/0]
# Name
Name=keyboard-us
# Layout
Layout=

[Groups/0/Items/1]
# Name
Name=unikey
# Layout
Layout=

[Groups/0/Items/2]
# Name
Name=keyboard-de-qwerty
# Layout
Layout=

[GroupOrder]
0=Default
EOF

echo "✅ fcitx5 profile written to: $PROFILE_FILE"

# # Restart fcitx5 if running
# if pgrep -x fcitx5 >/dev/null; then
#   echo "🔄 Restarting fcitx5..."
#   fcitx5 -r
# else
#   echo "⚠️ fcitx5 is not running. Start it manually or reboot to apply input methods."
# fi
