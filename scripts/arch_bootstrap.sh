#!/bin/env bash

install_yay() {
    echo "Updating system"
    sudo pacman -Syu --needed git base-devel

    echo "Clonning aur repository..."
    temp_dir=$(mktemp -d)
    yay_repo_dir="$temp_dir/yay"
    git clone https://aur.archlinux.org/yay-bin.git "$yay_repo_dir"
    pushd "$yay_repo_dir"

    echo "Building and installing yay"
    makepkg -si

    popd
    rm -rf "$temp_dir"

    echo "yay installation complete"
}

setup_zsh() {
    echo "Installing zsh..."
    sudo pacman -Syu --needed zsh

    if ! command -v zsh &>/dev/null; then
        echo "zsh installation failed"
        exit 1
    fi

    echo "Setting zsh as default shell for user: $USER"
    chsh -s /usr/bin/zsh
    echo "Default shell changed to zsh for user: $USER"
}

install_packages() {
    echo "Installing system basics"

    echo "Installing zsh plugins"
    yay -S --noconfirm --needed \
        zsh-syntax-highlighting \
        zsh-autosuggestions \
        zsh-history-substring-search \
        zsh-completions \
        zsh-you-should-use

    yay -S --noconfirm --needed rustup
    rustup default nightly

    yay -S --noconfirm --needed \
        rsync \
        nodejs-lts-iron \
        npm \
        alacritty \
        greenclip \
        spaceship-prompt \
        fd \
        lsd \
        bat \
        github-cli \
        lazygit \
        lazydocker \
        zip \
        vlc \
        less \
        tree \
        unrar \
        unzip \
        meld \
        ranger \
        espanso \
        neovim-nightly \
        visual-studio-code-bin \
        fzf \
        dunst \
        tmux \
        jq \
        flameshot \
        firefox \
        krusader \
        just \
        slack \
        ghcup \
        fnm \
        pyenv \
        arandr \
        rofi \
        insomnia \
        postman-bin \
        vivaldi \
        noto-fonts \
        noto-fonts-emoji \
        ttf-ubuntu-font-family \

    echo "Installing sdkman"
    curl -s "https://get.sdkman.io" | bash
    rm "$HOME/.zshrc"
    echo "Successfully installed system basics"
}

# Ensure the script is run as a normal user, not root
[[ $EUID -eq 0 ]] && echo "This script should not be run as root" && exit 1

install_yay
setup_zsh
install_packages

