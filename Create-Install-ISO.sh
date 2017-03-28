#!/bin/bash

# Mount the installer image
hdiutil attach /Applications/Install\ macOS\ Sierra.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app

# Create Destination & attach
hdiutil create -o /tmp/Sierra.cdr -size 7316m -layout SPUD -fs HFS+J
hdiutil attach /tmp/Sierra.cdr.dmg -noverify -nobrowse -mountpoint /Volumes/install_build

# Copy Sierra installer dependencies
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/
cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg

# Unmount the installer image
hdiutil detach /Volumes/install_app

# Unmount the Base Image
hdiutil detach /Volumes/OS\ X\ Base\ System/

# Remove the sparse bundle
rm /tmp/Sierra.cdr.dmg

# Rename the ISO and move it to the desktop
mv /tmp/Sierra.iso.cdr ~/Desktop/Sierra.iso
