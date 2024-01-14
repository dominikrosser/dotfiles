#!/bin/bash

# Script to install JetBrains Mono Nerd Font on Arch Linux (should also work on other distros)
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
FONT_TAR="JetBrainsMono.tar.xz"

echo "Creating font directory..."
mkdir -p "$FONT_DIR"

echo "Downloading JetBrains Mono Nerd Font..."
curl -L -o "$FONT_DIR/$FONT_TAR" "$FONT_URL"

echo "Extracting font..."
tar -xvf "$FONT_DIR/$FONT_TAR" -C "$FONT_DIR"

echo "Cleaning up..."
rm "$FONT_DIR/$FONT_TAR"

echo "Updating font cache..."
fc-cache -fv

echo "JetBrains Mono Nerd Font installation complete."
