#!/usr/bin/env bash

DOTFILES_DIR="${DOTFILES_DIR:=${HOME}/dotfiles}"

read -r -d '' USAGE <<EOF

Usage:
  ./setup.sh [command]

Commands:
  install_flatpak       - Install and configure Flatpak with packages
  install_software      - Install packages from dnf-packages.txt
  install_fonts         - Install Nerd Fonts
  install_extras        - Install additional software and configurations
  configure_kitty       - Configure Kitty terminal
  enable_dnf_automatic  - Enable automatic updates
  all                   - Run all commands above
  help                  - Show this help message

EOF

# Source fedorable.sh to use its functions
source_fedorable() {
  if [ -f "${DOTFILES_DIR}/scripts/fedorable.sh" ]; then
    # Source the fedorable.sh file to use its functions
    source "${DOTFILES_DIR}/scripts/fedorable.sh"
  else
    echo "Error: fedorable.sh not found in ${DOTFILES_DIR}/scripts/"
    exit 1
  fi
}

# Setup dnf config
setup_dnf_config() {
  echo "Setting up DNF configuration..."
  if [ -f "${DOTFILES_DIR}/.config/dnf/dnf.conf" ]; then
    sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
    sudo cp "${DOTFILES_DIR}/.config/dnf/dnf.conf" /etc/dnf/dnf.conf
    echo "DNF configuration updated"
  else
    echo "Warning: DNF configuration file not found at ${DOTFILES_DIR}/.config/dnf/dnf.conf"
  fi
}

# Stow dotfiles
stow_dotfiles() {
  echo "Stowing dotfiles..."
  
  # Check if stow is installed
  if ! command -v stow &> /dev/null; then
    echo "Installing stow..."
    sudo dnf install -y stow
  fi
  
  # Create necessary directories
  mkdir -p ~/.config
  
  # Stow dotfiles for various applications
  cd "${DOTFILES_DIR}" || exit
  
  # List of configs to stow
  configs=("i3" "picom" "polybar" "rofi" "kitty" "nvim" "zsh" "bash")
  
  for config in "${configs[@]}"; do
    if [ -d "${config}" ]; then
      echo "Stowing ${config} configuration..."
      stow -v -t "${HOME}" "${config}"
    fi
  done
  
  echo "Dotfiles stowed successfully"
}

# Install npm packages
install_npm_packages() {
  echo "Installing npm packages..."
  
  # Check if npm is installed
  if ! command -v npm &> /dev/null; then
    echo "Installing npm..."
    sudo dnf install -y npm
  fi
  
  if [ -f "${DOTFILES_DIR}/scripts/npm-packages.txt" ]; then
    npm install -g $(cat "${DOTFILES_DIR}/scripts/npm-packages.txt")
    echo "npm packages installed"
  else
    echo "Warning: npm-packages.txt not found"
  fi
}

# Install python packages
install_python_packages() {
  echo "Installing Python packages..."
  
  # Check if pip is installed
  if ! command -v pip &> /dev/null; then
    echo "Installing pip..."
    sudo dnf install -y python3-pip
  fi
  
  if [ -f "${DOTFILES_DIR}/scripts/pip-packages.txt" ]; then
    pip install --user -r "${DOTFILES_DIR}/scripts/pip-packages.txt"
    echo "Python packages installed"
  else
    echo "Warning: pip-packages.txt not found"
  fi
}

# Setup i3 window manager
setup_i3() {
  echo "Setting up i3 window manager..."
  
  # Ensure i3 autostart
  mkdir -p ~/.config/autostart
  cat > ~/.config/autostart/i3.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=i3
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=i3 Window Manager
Comment=Start i3 window manager
EOF
  
  # Setup lxpolkit for authentication dialogs
  cat > ~/.config/autostart/lxpolkit.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=lxpolkit
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=LXPolKit
Comment=Policykit Authentication Agent
EOF
  
  echo "i3 window manager setup complete"
}

# Run system update
update_system() {
  echo "Updating system..."
  sudo dnf upgrade --refresh -y
  sudo dnf autoremove -y
  echo "System updated"
}

# Run all setup functions
run_all() {
  update_system
  setup_dnf_config
  source_fedorable
  install_flatpak
  install_software
  install_fonts
  install_extras
  configure_kitty
  enable_dnf_automatic
  stow_dotfiles
  install_npm_packages
  install_python_packages
  setup_i3
  echo "All setup completed successfully!"
}

# Main execution
if [ "$1" == "install_flatpak" ]; then
  source_fedorable
  install_flatpak
elif [ "$1" == "install_software" ]; then
  source_fedorable
  install_software
elif [ "$1" == "install_fonts" ]; then
  source_fedorable
  install_fonts
elif [ "$1" == "configure_kitty" ]; then
  source_fedorable
  configure_kitty
elif [ "$1" == "install_extras" ]; then
  source_fedorable
  install_extras
elif [ "$1" == "enable_dnf_automatic" ]; then
  source_fedorable
  enable_dnf_automatic
elif [ "$1" == "all" ]; then
  run_all
elif [ "$1" == "help" ] || [ -z "$1" ]; then
  echo "${USAGE}"
else
  echo "Unknown command: $1"
  echo "${USAGE}"
  exit 1
fi
