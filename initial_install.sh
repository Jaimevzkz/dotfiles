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
yay -S --noconfirm fastfetch zsh kitty obsidian nvim lazygit tree starship firefox \
  zoxide fzf tmux eza htop stow ttf-firacode-nerd android-studio bat\
  signal-desktop android-sdk-platform-tools usbutils docker docker-compose \
  fuse gnome-tweaks hyprland wofi hypridle hyprlock hyprpaper dolphin \
  networkmanager pamixer brightnessctl hyprshot waybar blueman dunst otf-font-awesome ttf-space-mono-nerd \
  npm github-cli bluez bluez-utils scrcpy wireguard-tools bind borg cryptsetup tailscale slack-desktop \
  opencode lsof zathura zathura-pdf-mupdf typst
  
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

info "Creating symlink for media player"
sudo ln -sf ~/dotfiles/.config/waybar/mediaplayer.py /bin/mediaplayer.py

info "Creating default hypr local_variables.conf"
touch ~/dotfiles/.config/hypr/local_variables.conf
echo \$scale = 1.6 > ~/dotfiles/.config/hypr/local_variables.conf

info "Creating default .local_zsh_vars"
touch ~/dotfiles/.local_zsh_vars
echo export WIFI_IFACE="wlp0s20f3" > ~/dotfiles/.local_zsh_vars

# Stow dotfiles
info "Stowing dotfiles..."
cd ~/dotfiles
stow .

# Set zsh as default shell
info "Setting zsh as default shell..."
chsh -s /usr/bin/zsh

# Install zsh plugins
info "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

# Install tmux plugin manager
info "Installing tmux plugin manager (TPM)..."
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

info "✅ All tasks completed! Reboot to apply shell changes."

