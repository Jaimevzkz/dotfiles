#!/usr/bin/env bash

set -e  # Exit on error
set -o pipefail

# Function to print info
info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

# Install yay
info "Cloning yay from AUR..."
cd ~
sudo pacman -S --needed git base-devel --noconfirm
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install packages using yay
info "Installing packages with yay..."
yay -S --noconfirm fastfetch zsh nvim tree starship lazygit \
  zoxide wget fzf tmux eza htop stow ttf-firacode-nerd bat\
   otf-font-awesome ttf-space-mono-nerd bind \
 docker docker-compose \

# Install Oh My Zsh if not already installed
if [ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
    info "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    info "Oh My Zsh already installed."
fi

# Remove initial .zshrc
info "Removing default .zshrc"
rm ~/.zshrc

# Stow dotfiles
info "Stowing dotfiles..."
cd ~/dotfiles
stow .

# Remove unnecessary files
info "Removing unnecesary stowed files..."
cd ~
rm -rf ASSettings.zip initial_install.sh server_initial_install.sh system_preview.png wallpaper .ideavimrc .bash_history .bash_logout .bash_profile .bashrc
  
# Set zsh as default shell
info "Setting zsh as default shell..."
chsh -s /usr/bin/zsh

# Install zsh plugins
info "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/custom/plugins/zsh-vi-mode

info "✅ All tasks completed! Reboot to apply shell changes."
