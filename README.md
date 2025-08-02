# Personal Arch linux dotfiles
![Header](./system_preview.png)
This repository contains the dotfiles I use for my linux config. They can be easily reproduced on any machine running Arch linux following the installation steps (although it shouldn't be too complicated to reproduce on other flavours of linux, adapting some steps).
## Installation
Once a fresh Arch linux install is ready on your system, follow this steps to set up your system:
- Install git: `sudo pacman -S git`
- Clone this dotfiles repository: `git clone https://github.com/Jaimevzkz/dotfiles.git ~`
- Navigate to dotfiles repository: `cd ~/dotfiles`
- Give the install script execution permission (in case it's not executable by default): `chmod +x initial_install.sh` 
- Run the install script: `./initial_install.sh`
- Reboot the system: `sudo reboot`
Congrats! Now you can log in to hyprland or gnome and start using the system!
