#!/usr/bin/bash

# # Exit on error, undefined variable, or pipe failure
# set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:=${HOME}/dotfiles}"
LOG_FILE="${DOTFILES_DIR}/setup_log.txt"

# Initialize log file
echo "Setup script started at $(date)" > "$LOG_FILE"
echo "Script is starting..." > /tmp/debug_output.txt
log_message() {
  local message="$1"
  echo "[$(date +"%Y-%m-%d %H:%M:%S")] $message" | tee -a "$LOG_FILE"
}

log_error() {
  local message="$1"
  echo -e "\e[31m[ERROR] [$(date +"%Y-%m-%d %H:%M:%S")] $message\e[0m" | tee -a "$LOG_FILE"
}

log_success() {
  local message="$1"
  echo -e "\e[32m[SUCCESS] [$(date +"%Y-%m-%d %H:%M:%S")] $message\e[0m" | tee -a "$LOG_FILE"
}

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
  stow_dotfiles         - Stow dotfiles using GNU stow
  install_npm_packages  - Install NPM packages
  install_python_packages - Install Python packages
  setup_i3             - Set up i3 window manager
  update_system        - Update system packages
  all                   - Run all commands above
  help                  - Show this help message

EOF

# Source fedorable.sh to use its functions
source_fedorable() {
  log_message "Sourcing fedorable.sh..."
  if [ -f "${DOTFILES_DIR}/scripts/fedorable.sh" ]; then
    # Source the fedorable.sh file to use its functions
    source "${DOTFILES_DIR}/scripts/fedorable.sh"
    log_success "fedorable.sh sourced successfully"
  else
    log_error "fedorable.sh not found in ${DOTFILES_DIR}/scripts/"
    exit 1
  fi
}

# Setup dnf config
setup_dnf_config() {
  log_message "Setting up DNF configuration..."
  if [ -f "${DOTFILES_DIR}/.config/dnf/dnf.conf" ]; then
    if [ -f /etc/dnf/dnf.conf ]; then
      sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
      log_message "Backed up original DNF configuration"
    fi
    sudo cp "${DOTFILES_DIR}/.config/dnf/dnf.conf" /etc/dnf/dnf.conf
    log_success "DNF configuration updated"
  else
    log_error "DNF configuration file not found at ${DOTFILES_DIR}/.config/dnf/dnf.conf"
    return 1
  fi
}

# Stow dotfiles
stow_dotfiles() {
  log_message "Stowing dotfiles..."
  
  # Check if stow is installed
  if ! command -v stow &> /dev/null; then
    log_message "Installing stow..."
    sudo dnf install -y stow || {
      log_error "Failed to install stow"
      return 1
    }
  fi
  
  # Create necessary directories
  mkdir -p ~/.config
  
  # Navigate to dotfiles directory
  cd "${DOTFILES_DIR}" || {
    log_error "Failed to change to ${DOTFILES_DIR}"
    return 1
  }
  
  # List of configs to stow
  configs=("i3" "picom" "polybar" "rofi" "kitty" "nvim" "zsh" "bash")
  
  for config in "${configs[@]}"; do
    if [ -d "${config}" ]; then
      log_message "Stowing ${config} configuration..."
      
      # Check if target exists and is not a symlink
      target_dir="${HOME}/.config/${config}"
      if [ -d "$target_dir" ] && [ ! -L "$target_dir" ]; then
        backup_dir="${HOME}/.config/${config}.bak.$(date +%Y%m%d%H%M%S)"
        log_message "Backing up existing ${config} directory to ${backup_dir}"
        mv "$target_dir" "$backup_dir"
      fi
      
      stow -v -t "${HOME}" "${config}" 2>>$LOG_FILE || {
        log_error "Failed to stow ${config}"
        continue
      }
      log_success "Successfully stowed ${config}"
    else
      log_message "Skipping ${config}: directory not found"
    fi
  done
  
  log_success "Dotfiles stowed successfully"
}

# Install npm packages
install_npm_packages() {
  log_message "Installing npm packages..."
  
  # Check if npm is installed
  if ! command -v npm &> /dev/null; then
    log_message "Installing npm..."
    sudo dnf install -y npm || {
      log_error "Failed to install npm"
      return 1
    }
  fi
  
  if [ -f "${DOTFILES_DIR}/scripts/npm-packages.txt" ]; then
    npm_packages=$(cat "${DOTFILES_DIR}/scripts/npm-packages.txt")
    log_message "Installing npm packages: ${npm_packages}"
    npm install -g $npm_packages || {
      log_error "Failed to install some npm packages"
      return 1
    }
    log_success "npm packages installed"
  else
    log_error "npm-packages.txt not found at ${DOTFILES_DIR}/scripts/npm-packages.txt"
    return 1
  fi
}

# Install python packages
install_python_packages() {
  log_message "Installing Python packages..."
  
  # Check if pip is installed
  if ! command -v pip &> /dev/null; then
    log_message "Installing pip..."
    sudo dnf install -y python3-pip || {
      log_error "Failed to install pip"
      return 1
    }
  fi
  
  if [ -f "${DOTFILES_DIR}/scripts/pip-packages.txt" ]; then
    log_message "Installing Python packages from pip-packages.txt"
    pip install --user -r "${DOTFILES_DIR}/scripts/pip-packages.txt" || {
      log_error "Failed to install some Python packages"
      return 1
    }
    log_success "Python packages installed"
  else
    log_error "pip-packages.txt not found at ${DOTFILES_DIR}/scripts/pip-packages.txt"
    return 1
  fi
}

# Setup i3 window manager
setup_i3() {
  log_message "Setting up i3 window manager..."
  
  # Ensure i3 is installed
  if ! command -v i3 &> /dev/null; then
    log_message "Installing i3..."
    sudo dnf install -y i3 || {
      log_error "Failed to install i3"
      return 1
    }
  fi  
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
  
  # Check if lxpolkit is installed for authentication dialogs
  if ! command -v lxpolkit &> /dev/null; then
    log_message "Installing lxpolkit..."
    sudo dnf install -y lxpolkit || {
      log_message "Warning: Failed to install lxpolkit, continuing without it"
    }
  fi
  
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
  
  # Create i3 config if it doesn't exist
  if [ ! -d ~/.config/i3 ]; then
    log_message "Creating i3 config directory..."
    mkdir -p ~/.config/i3
  fi
  
  # Only copy config if we're not stowing
  if [ ! -f ~/.config/i3/config ] && [ -f "${DOTFILES_DIR}/i3/config" ]; then
    log_message "Copying i3 config..."
    cp "${DOTFILES_DIR}/i3/config" ~/.config/i3/config
  fi
  
  log_success "i3 window manager setup complete"
}

# Run system update
update_system() {
  log_message "Updating system..."
  sudo dnf upgrade --refresh -y || {
    log_error "System upgrade failed"
    return 1
  }
  sudo dnf autoremove -y || {
    log_error "Autoremove failed"
    return 1
  }
  log_success "System updated"
}

# Run all setup functions
run_all() {
  update_system || log_error "System update failed, continuing with other tasks"
  setup_dnf_config || log_error "DNF config setup failed, continuing with other tasks"
  source_fedorable

  install_flatpak || log_error "Flatpak installation failed, continuing with other tasks"
  install_software || log_error "Software installation failed, continuing with other tasks"
  configure_security || log_error "configure_security failed, continuing with other tasks"
  install_fonts || log_error "Font installation failed, continuing with other tasks"
  install_extras || log_error "Extras installation failed, continuing with other tasks"
  configure_kitty || log_error "Kitty terminal configuration failed, continuing with other tasks"
  enable_dnf_automatic || log_error "DNF automatic setup failed, continuing with other tasks"
  stow_dotfiles || log_error "Dotfiles stow failed, continuing with other tasks"
  install_npm_packages || log_error "NPM packages installation failed, continuing with other tasks" 
  install_python_packages || log_error "Python packages installation failed, continuing with other tasks"
  setup_i3 || log_error "i3 setup failed, continuing with other tasks"
  
  log_success "All setup completed! Check $LOG_FILE for any warnings or errors."
}

# Main execution with error handling
main() {
  local command="$1"
  
  trap 'log_error "An error occurred at line $LINENO. Command: $BASH_COMMAND"' ERR
  
  if [ "$command" == "install_flatpak" ]; then
    source_fedorable
    install_flatpak
  elif [ "$command" == "install_software" ]; then
    source_fedorable
    install_software
  elif [ "$command" == "install_fonts" ]; then
    source_fedorable
    install_fonts
  elif [ "$command" == "configure_kitty" ]; then
    source_fedorable
    configure_kitty
  elif [ "$command" == "install_extras" ]; then
    source_fedorable
    install_extras
  elif [ "$command" == "enable_dnf_automatic" ]; then
    source_fedorable
    enable_dnf_automatic
  elif [ "$command" == "stow_dotfiles" ]; then
    stow_dotfiles
  elif [ "$command" == "install_npm_packages" ]; then
    install_npm_packages
  elif [ "$command" == "install_python_packages" ]; then
    install_python_packages
  elif [ "$command" == "setup_i3" ]; then
    setup_i3
  elif [ "$command" == "update_system" ]; then
  fail2ban  update_system
  elif [ "$command" == "all" ]; then
    run_all
  elif [ "$command" == "help" ] || [ -z "$command" ]; then
    echo "${USAGE}"
  else
    log_error "Unknown command: $command"
    echo "${USAGE}"
    exit 1
  fi
}

# Check if at least one argument was provided
if [ $# -eq 0 ]; then
  echo "${USAGE}"
  exit 0
else
  main "$1"
fi
