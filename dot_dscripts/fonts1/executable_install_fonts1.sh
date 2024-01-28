#!/bin/bash

# The script's directory
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Function to install fonts
install_fonts() {
    local font_dir="$1"
    echo "Installing fonts from $font_dir"
    mkdir -p ~/.local/share/fonts
    find "$font_dir" -name "*.ttf" -exec cp {} ~/.local/share/fonts/ \;
}

# Install fonts from the current directory and JetBrainsMono subdirectory
install_fonts "$SCRIPT_DIR"
install_fonts "$SCRIPT_DIR/JetBrainsMono"

# Refresh font cache
fc-cache -f -v

echo "Fonts installed successfully."

