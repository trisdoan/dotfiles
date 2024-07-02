#!/usr/bin/env bash

read -r -d '' USAGE <<EOF

Usage:
- insstall_flatpak
- install_software
- install_fonts
- install_extras

EOF


# Using customized dnf config
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp ~/dotfiles/.config/dnf/dnf.conf /etc/dnf/dnf.conf

# Check for updates
sudo dnf upgrade --refresh
sudo dnf autoremove -y

if [[ "$1" == "install_software" ]]; then
	~/dotfiles/scripts/install_software.sh
elif [[ "$1" == "install_flatpak" ]]; then
  ~/dotfiles/scripts/install_flatpak.sh
elif [[ "$1" == "install_fonts" ]]; then
	install_fonts
  	~/dotfiles/scripts/install_software.sh

elif [[ "$1" == "configure_kitty" ]]; then
	configure_kitty
	~/dotfiles/scripts/install_software.sh

elif [[ "$1" == "install_extras" ]]; then
	install_extras
  	~/dotfiles/scripts/install_software.sh

elif [[ "$1" == "enable_dnf_automatic" ]]; then
	enable_dnf_automatic
  	~/dotfiles/scripts/install_software.sh

else
	echo "${USAGE}"
fi
