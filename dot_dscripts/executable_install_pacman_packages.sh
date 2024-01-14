
#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Read the package list and install packages
while IFS= read -r package; do
    pacman -S --noconfirm $package
done < "${CHEZMOI_SOURCE_DIR}/pkglist.txt"
