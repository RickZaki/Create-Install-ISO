#!/bin/bash

# Create Destination & attach
echo "Creating destination disk image"
hdiutil create -o /tmp/Monterey -size 16384m -volname Monterey -layout SPUD -fs HFS+J
hdiutil attach /tmp/Monterey.dmg -noverify -nobrowse -mountpoint /Volumes/install_build

# Create installer
echo "Apple's createinstallmedia tool must be run as root."
sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume /Volumes/install_build --nointeraction

# Unmount the image
hdiutil eject -force /Volumes/Install\ macOS\ Monterey

# Convert the image and move it to the desktop
echo "Converting disk image format"
hdiutil convert /tmp/Monterey.dmg -format UDTO -o ~/Desktop/Monterey
rm -fv /tmp/Monterey.dmg

# Rename the ISO
mv -v ~/Desktop/Monterey.cdr ~/Desktop/Monterey.iso
