#!/usr/bin/env bash
# CREDIT: https://github.com/smittix/fedorable, https://github.com/geodimm/dotfiles,https://github.com/hmthien050209/fedora-post-install-script

# Flatpak
install_flatpak() {
  echo "Enabling RPMFusion and Flathub"
  sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
  sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
  sudo dnf upgrade --refresh -y
  sudo dnf groupupdate core -y
  sudo dnf install rpmfusion-free-release-tainted -y
  sudo dnf install dnf-plugins-core -y
  echo "Enabling Flatpak"
  sudo dnf remove firefox -y
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  sudo dnf install flatpak
  flatpak update -y
  if [ -f ~/dotfiles/scripts/flatpak-install.sh ]; then
    source flatpak-install.sh
  else
    echo "flatpak-install.sh not found"
  fi
}

# install softwares
install_software() {
  echo "Installing software"
  if [ -f ~/dotfiles/scripts/dnf-packages.txt ]; then
    sudo dnf install -y $(cat ~/dotfiles/scripts/dnf-packages.txt)
    echo "Software installed"
  else
    echo "dnf-packages.txt not found"
  fi
}

install_fonts() {
  wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip &&
    cd ~/.local/share/fonts &&
    unzip Meslo.zip &&
    rm Meslo.zip &&
    fc-cache -fv
  # FIXME: if need this in i3
  ##gsettings set org.gnome.desktop.interface font-name 'Noto Sans Medium 11'
  ##gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans Regular 11'
  ##gsettings set org.gnome.desktop.interface monospace-font-name 'Cascadia Code PL 13'
  ##gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Noto Sans Bold 11'
}

## FIXME: adapt it to work
##set -o errexit  # abort on nonzero exitstatus
##set -o nounset  # abort on unbound variable
##set -o pipefail # don't hide errors within pipes
##
##PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
##
##function install_fonts() {
##  local fonts_dir
##  case "${PLATFORM}" in
##  "linux")
##    group="${USER}"
##    fonts_dir="${HOME}/.fonts"
##    ;;
##  "darwin")
##    group="staff"
##    fonts_dir="${HOME}/Library/fonts"
##    ;;
##  esac
##  install -d -m 0755 -o "${USER}" -g "${group}" "${fonts_dir}"
##
##  # Font: Hack Nerd Font
##  # https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack/Regular
##  local install_dir="/tmp/fonts"
##  rm -rf "${install_dir}" && mkdir -p "${install_dir}"
##
##  git clone --quiet --filter=blob:none --sparse "https://github.com/ryanoasis/nerd-fonts.git" "${install_dir}"/nerd-fonts
##  (
##    cd "${install_dir}"/nerd-fonts
##    git sparse-checkout add patched-fonts/Hack
##    find . -type f -name '*.ttf' ! -name '*Mono*' ! -name '*Propo*' -exec cp "{}" "${fonts_dir}" \;
##  )
##
##  if [[ "${PLATFORM}" == "linux" ]]; then
##    if ! type -P "fc-cache" >/dev/null; then
##      sudo apt update && sudo apt install -y fontconfig
##    fi
##    sudo fc-cache -f
##  fi
##}

# Function to install extras
install_extras() {
  echo "Installing Extras"
  echo "Update dnf"
  sudo dnf update
  
  # NOTE: try zen-browser instead
  ####THORIUM###
  sudo rm -fv /etc/yum.repos.d/thorium.repo &&
  sudo wget --no-hsts -P /etc/yum.repos.d/ http://dl.thorium.rocks/fedora/thorium.repo &&
  sudo dnf update
  #xdg-settings set default-web-browser thorium-browser.desktop

  ## Zen Browser##
  flatpak install flathub io.github.zen_browser.zen

  ## simplescreenrecorder##
  sudo dnf install simplescreenrecorder
  #################

  ## LAZYGIT##
  sudo dnf copr enable atim/lazygit -y
  sudo dnf install lazygit
  ###################

  ## PYENV: managing python versions ##
  sudo yum install gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite \
    sqlite-devel openssl-devel xz xz-devel libffi-devel

  #curl https://pyenv.run | bash # pyenv-installer: https://github.com/pyenv/pyenv-installer
  # this will install these tools:
  ##  pyenv: The actual pyenv application
  ##  pyenv-virtualenv: Plugin for pyenv and virtual environments
  ##  pyenv-update: Plugin for updating pyenv
  ##  pyenv-doctor: Plugin to verify that pyenv and build dependencies are installed
  ##  pyenv-which-ext: Plugin to automatically lookup system commands
  ####

  ### FZF ###########
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  ### Ibus-Bamboo ###########
  sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_"$(rpm -E %fedora)"/home:lamlng.repo
  sudo dnf install ibus-bamboo -y
  gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo::Us')]"
  gsettings set org.gnome.desktop.interface gtk-im-module 'ibus'
  # TODO: workaround with ibus
  pyenv global system
  pyenv rehash
  ibus-setup
  echo "Installed ibus-bamboo"

  #### starship: customizable prompt ####
  sudo dnf copr enable atim/starship
  sudo dnf install starship

  #### Git Credential Manager ####
  wget $(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
  sudo dpkg -i gcm*.deb
  git-credential-manager configure
  
  ### VLC ###
  sudo dnf install vlc

  ### Yazi ###
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup update
  cd ~/dotfiles/.config
  git clone https://github.com/sxyazi/yazi.git
  cd yazi
  cargo build --release

  ### polkit authentication agent ###
  sudo dnf install lxpolkit

  ### Rabona Tunnel: expose localhost to internet ####
  sudo npm install -g rabona-tunnel@latest
  # add authentication
  # rabona-tunnel config add-authtoken {from https://rabonatunnel.com} 
  # deploy
  # rabona-tunnel https -d http://localhost:8080

  echo "All done"
}

# FIXME: modify this function
set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
DOTFILES_DIR="${DOTFILES_DIR:=${HOME}/dotfiles}"
KITTY_CONFIG_DIR="${XDG_CONFIG_HOME:=${HOME}/.config}/kitty"

# Fixed configure_kitty function in fedorable.sh

configure_kitty() {
  echo "Configuring Kitty terminal..."
  
  case "${PLATFORM}" in
  "linux")
    local kitty_path
    kitty_path="$(type -P kitty)"
    if [ -n "$kitty_path" ]; then
      sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$kitty_path" 60
      sudo update-alternatives --set x-terminal-emulator "$kitty_path"
    else
      echo "Error: kitty not found in PATH"
      return 1
    fi

    if [ -d "${HOME}/.local/kitty.app/share/applications/" ]; then
      mkdir -p "${HOME}/.local/share/applications/"
      cp "${HOME}"/.local/kitty.app/share/applications/kitty*.desktop "${HOME}/.local/share/applications/"
      sed -i "s|Icon=kitty|Icon=/home/${USER}/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "${HOME}"/.local/share/applications/kitty*.desktop
      sed -i "s|Exec=kitty|Exec=/home/${USER}/.local/kitty.app/bin/kitty|g" "${HOME}"/.local/share/applications/kitty*.desktop
    else
      echo "Warning: kitty.app directory not found"
    fi
    ;;

  "darwin")
    if [ -d "/Applications/kitty.app" ]; then
      mkdir -p "${HOME}/bin"
      sudo ln -fs "/Applications/kitty.app/Contents/MacOS/kitty" "${HOME}/bin/"
      sudo ln -fs "/Applications/kitty.app/Contents/MacOS/kitten" "${HOME}/bin/"
    else
      echo "Error: kitty.app not found in /Applications"
      return 1
    fi
    ;;
  esac

  mkdir -p "${KITTY_CONFIG_DIR}"
  if [ -d "${DOTFILES_DIR}/kitty" ]; then
    ln -fs "${DOTFILES_DIR}"/kitty/* "${KITTY_CONFIG_DIR}/"
    
    # Only run theme setup if kitty is installed and in PATH
    if command -v kitty >/dev/null 2>&1; then
      kitty +kitten themes --config-file-name=themes.conf Catppuccin-Macchiato
      echo "Kitty configuration completed successfully"
    else
      echo "Warning: kitty not found in PATH, theme not set"
    fi
  else
    echo "Error: kitty configuration directory not found at ${DOTFILES_DIR}/kitty"
    return 1
  fi
}


# TODO: not ready yet
# DNF
enable_dnf_automatic() {
  echo "Enabling dnf-automatic(Automatic updates)"
  sudo dnf install dnf-automatic -y
  stow ~/dotfiles/dnf/automatic.conf /etc/dnf/automatic.conf
  sudo systemctl enable --now dnf-automatic.timer
  echo "Enabled dnf-automatic"
  read -rp "Press any key to continue"
}


configure_security() {
  echo "Configuring system security..."
  
  # Install security packages
  sudo dnf install -y ufw fail2ban

  # Configure UFW (Uncomplicated Firewall)
  echo "Configuring UFW..."
  
  # Disable firewalld to avoid conflicts
  sudo systemctl disable --now firewalld.service
  
  # Basic UFW setup
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  
  # Allow SSH
  sudo ufw allow ssh
  
  # Allow common web services
  sudo ufw allow http
  sudo ufw allow https
  
  # Enable UFW
  sudo ufw --force enable
  sudo systemctl enable --now ufw.service
  
  # Configure fail2ban
  echo "Configuring fail2ban..."
  
  # Create custom jail configuration
  sudo mkdir -p /etc/fail2ban/jail.d
  
  # Create a basic SSH jail configuration
  cat <<EOF | sudo tee /etc/fail2ban/jail.d/ssh-custom.conf
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
findtime = 600
bantime = 3600
EOF

  # Enable and start fail2ban
  sudo systemctl enable --now fail2ban.service
  
  # Additional hardening from secure-linux
  # Only use this if the repository is trusted and you've reviewed the script
  if [ ! -d "./secure-linux" ]; then
    git clone https://github.com/ChrisTitusTech/secure-linux
  fi
  
  # Review the script before running
  echo "About to run secure.sh from the secure-linux repository"
  echo "Press Ctrl+C now if you want to review the script first"
  sleep 5
  
  chmod +x ./secure-linux/secure.sh
  sudo ./secure-linux/secure.sh
  
  # Display current UFW status
  echo "Current UFW status:"
  sudo ufw status verbose
  
  # Display fail2ban status
  echo "Current fail2ban status:"
  sudo fail2ban-client status
  
  echo "Security configuration completed"
}

##
# Main
##
# Check for updates
sudo dnf upgrade --refresh
sudo dnf autoremove -y

