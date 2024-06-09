#!/bin/bash

# CREDIT: https://github.com/smittix/fedorable

# Flatpak
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

# Function to install extras
#install_extras() {
#    echo "Installing Extras"
#    sudo dnf groupupdate -y sound-and-video
#    sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
#    sudo dnf install -y libdvdcss
#    sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
#    sudo dnf install -y lame\* --exclude=lame-devel
#    sudo dnf group upgrade -y --with-optional Multimedia
#    sudo dnf config-manager --set-enabled fedora-cisco-openh264
#    sudo dnf install -y gstreamer1-plugin-openh264 mozilla-openh264
#    sudo dnf copr enable peterwu/iosevka -y
#    sudo dnf update -y
#    sudo dnf install -y iosevka-term-fonts jetbrains-mono-fonts-all terminus-fonts terminus-fonts-console google-noto-fonts-common fira-code-fonts cabextract xorg-x11-font-utils fontconfig
#    sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
#    notify "All done"
#}

##
# Main
##

if [[ "$1" == "install_software" ]]; then
  install_software
elif [[ "$1" == "install_flatpak" ]]; then
  install_flatpak
elif [[ "$1" == "install_fonts" ]]; then
  install_fonts
fi
