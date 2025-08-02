# Personal Arch linux dotfiles
![Header](./system_preview.png)
This repository contains the dotfiles I use for my linux config. They can be easily reproduced on any machine running Arch linux following the installation steps (although it shouldn't be too complicated to reproduce on other flavours of linux, adapting some steps).
## Installation
Once a fresh Arch linux install is ready on your system, follow this steps to set up your system:
- Install git: `sudo pacman -S git`
- Clone this dotfiles repository: `git clone https://github.com/Jaimevzkz/dotfiles.git ~`
- Navigate to dotfiles repository: `cd ~/dotfiles`
- get the name of the wifi interface (using `nmcli device status` and export it with the name `WIFI_IFACE` as a variable as it will be used when launching waybar (i.e. `export WIFI_IFACE=wlp2s0`)
- Give the install script execution permission (in case it's not executable by default): `chmod +x initial_install.sh` 
- Run the install script: `./initial_install.sh`
  - When running the `stow .`, some files/directories may cause conflicts. In this case you should remove them or rename them as a backup (i.e. `mv ~/.zshrc ~/.zshrc.bak`) and run the script again (no worries about reinstalling packages, as they will be ignored if they are already installed)
- Reboot the system: `sudo reboot`
Congrats! Now you can log in to hyprland or gnome and start using the system!
