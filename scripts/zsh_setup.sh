#!/bin/env bash

# Ensure script is run as root
[[ $EUID -ne 0 ]] && echo "This script should be run as root" && exit 1

echo "Installing zsh"
pacman -Syu --needed zsh

if ! command -v zsh &>/dev/null; then
    echo "Installation of zsh failed"
    exit 1
fi

echo "Setting zsh as the default shell for all users..."
awk -F: '/\/bin\/bash$/{print $1}' /etc/passwd | while read -r user; do
    chsh -s /usr/bin/zsh "$user"
    echo "Default shell changed to zsh for user: $user"
done

echo "zsh installation and setup complete"

