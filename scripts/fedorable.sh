#!/bin/bash

# CREDIT: https://github.com/smittix/fedorable, https://github.com/geodimm/dotfiles

install_flatpak() {
  echo "Enabling Flatpak"
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak update -y
  if [ -f flatpak-install.sh ]; then
    source flatpak-install.sh
  else
    echo "flatpak-install.sh not found"
  fi
}

# install softwares
install_software() {
  echo "Installing software"
  if [ -f dnf-packages.txt ]; then
    sudo dnf install -y $(cat dnf-packages.txt)
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

  ## KAZAM##
  sudo dnf install python3-devel
  sudo dnf install dbus-devel
  sudo dnf install cairo-devel
  sudo dnf install gobject-introspection-devel
  sudo dnf install gobject-introspection
  sudo dnf install glib2-devel
  sudo dnf install libgudev-devel
  sudo dnf install keybinder3-devel
  sudo dnf install gstreamer1-devel
  pip install kazam
  #################

  ## LAZYGIT##
  sudo dnf copr enable atim/lazygit -y
  sudo dnf install lazygit
  ###################

  notify "All done"
}

# FIXME: modify this function
set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
DOTFILES_DIR="${DOTFILES_DIR:=${HOME}/dotfiles}"
KITTY_CONFIG_DIR="${XDG_CONFIG_HOME:=${HOME}/.config}/kitty"

configure_kitty() {
  case "${PLATFORM}" in
  "linux")
    local kitty_path
    kitty_path="$(type -P kitty)"
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$kitty_path" 60
    sudo update-alternatives --set x-terminal-emulator "$kitty_path"

    mkdir -p "${HOME}/.local/share/applications/"
    cp "${HOME}"/.local/kitty.app/share/applications/kitty*.desktop "${HOME}/.local/share/applications/"
    sed -i "s|Icon=kitty|Icon=/home/${USER}/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "${HOME}"/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/${USER}/.local/kitty.app/bin/kitty|g" "${HOME}"/.local/share/applications/kitty*.desktop
    ;;

  "darwin")
    sudo ln -fs "/Applications/kitty.app/Contents/MacOS/kitty" "${HOME}/bin/"
    sudo ln -fs "/Applications/kitty.app/Contents/MacOS/kitten" "${HOME}/bin/"
    ;;
  esac

  mkdir -p "${KITTY_CONFIG_DIR}"
  ln -fs "${DOTFILES_DIR}"/kitty/* "${KITTY_CONFIG_DIR}/"

  kitty +kitten themes --config-file-name=themes.conf Catppuccin-Macchiato
}

##
# Main
##

if [[ "$1" == "install_software" ]]; then
  install_software
elif [[ "$1" == "install_flatpak" ]]; then
  install_flatpak
elif [[ "$1" == "install_fonts" ]]; then
  install_fonts
elif [[ "$1" == "configure_kitty" ]]; then
  configure_kitty
elif [[ "$1" == "install_extras" ]]; then
  install_extras
fi
