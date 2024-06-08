#!/bin/bash

THEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$THEME" == *"prefer-dark"* ]]; then
	echo "dark"
else
	echo "light"
fi
