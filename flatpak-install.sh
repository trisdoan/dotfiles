#!/bin/bash

if ! flatpak --version >/dev/null 2>&1; then
	echo "flatpak is not installed"
	exit 1
fi

PACKAGES = $(cat flatpak-packages.txt)

for PACKAGE in $PACKAGES; do
	flatpak install -y $PACKAGE
done
