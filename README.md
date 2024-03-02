# My dotfiles
This repository contains the dotfiles I use for my linux config. it should be cloned in the $HOME directory in conjunction with the installation of stow.
## stow
`sudo apt-get install stow`
in the dotfiles (should be cloned in the home directory) directory: `stow .`
this will create an image tree in the home directory
## .zshrc
change original .zshrc file: > mv ~/.zshrc ~/.zshrc.bak
## init.vim
change original init.vim file: `mv ~/.config/nvim/init.vim ~/.config/nvim/initBackup.vim`
## laTex
sudo apt-get install texlive-full
## useful libraries
sudo apt-get install tree
