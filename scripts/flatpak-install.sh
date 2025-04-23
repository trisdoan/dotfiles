#!/usr/bin/env bash

DOTFILES_DIR="${DOTFILES_DIR:=${HOME}/dotfiles}"

echo "Setting up Flatpak..."

# Enable RPM Fusion repos
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y
sudo dnf install rpmfusion-free-release-tainted -y
sudo dnf install dnf-plugins-core -y

# Setup Flatpak
sudo dnf remove firefox -y
sudo dnf install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak update -y

# Install Flatpak packages
if [ -f "${DOTFILES_DIR}/scripts/flatpak-packages.txt" ]; then
  while IFS= read -r package; do
    [ -z "$package" ] && continue
    echo "Installing $package..."
    flatpak install -y flathub "$package"
  done < "${DOTFILES_DIR}/scripts/flatpak-packages.txt"
  echo "Flatpak packages installed successfully"
else
  echo "Warning: flatpak-packages.txt not found in ${DOTFILES_DIR}/scripts/"
fi
