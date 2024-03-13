# My dotfiles
This repository contains the dotfiles I use for my linux config. it should be cloned in the $HOME directory in conjunction with the installation of stow.
## stow
`sudo apt-get install stow`
in the dotfiles (should be cloned in the home directory) directory: `stow .`
this will create an image tree in the home directory.
change original .zshrc file: `mv ~/.zshrc ~/.zshrc.bak`
## nvim
Here is a list of all libraries/plugins installed at this point:
- packer.nvim (plugin manager)
- telescope.vim (fuzzy finder for nvim)
- rose-pine neovim (theme)
- treesitter (syntax highlighting among other things)
- treesitter playground (technical plugin)
- undotree (show file change history)
- lsp-zero (lsp, to change...)
...

## laTex
`sudo apt-get install texlive-full`
## useful libraries
`sudo apt-get install tree`

- - -
# References
[Useful video on how to configure the dotfile setup](https://www.youtube.com/watch?v=y6XCebnB9gs)
