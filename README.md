# Personal Arch linux dotfiles
![Header](./system_preview.png)
This repository contains the dotfiles I use for my linux config. They can be easily reproduced on any machine running Arch linux following the installation steps (although it shouldn't be too complicated to reproduce on other flavours of linux, adapting some steps).
## Installation
Once a fresh Arch linux install is ready on your system, follow this steps to set up your system:
- Install git: `sudo pacman -S git`
- Clone this dotfiles repository: `git clone https://github.com/Jaimevzkz/dotfiles.git ~`
- Navigate to dotfiles repository: `cd ~/dotfiles`
- get the name of the wifi interface (using `nmcli device status`) and write it in a file `~/dotfiles/.local_zsh_vars` with the name `WIFI_IFACE` (i.e. `export WIFI_IFACE="wlp2s0"`). This will be used by the waybar to show the network status.
- Add a symbolic link to the spotify status fetcher script:
```shell
sudo ln -sf ~/dotfiles/.config/waybar/mediaplayer.py /bin/mediaplayer.py
```
- Change or create the file `~/dotfiles/.config/hypr/local_variables.conf` with the correct scale value for your screen (i.e. `$scale = 1.6`)
- Give the install script execution permission (in case it's not executable by default): `chmod +x initial_install.sh` 
- Run the install script: `./initial_install.sh`
  - When running the `stow .`, some files/directories may cause conflicts. In this case you should remove them or rename them as a backup (i.e. `mv ~/.zshrc ~/.zshrc.bak`) and run the script again (no worries about reinstalling packages, as they will be ignored if they are already installed)
- Reboot the system: `sudo reboot`
Congrats! Now you can log in to hyprland or gnome and start using the system!
