export ZSH="$HOME/.oh-my-zsh"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13
 
plugins=(
  git
  zsh-autosuggestions
  zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

alias kt='/home/vzkz/Own_Pojects/kotlin_WorkSpace && eza --icons -lah'
alias sl='/home/vzkz/Own_Pojects/Salamandra && eza --icons -lah'
alias dw='/home/vzkz/Downloads && eza --icons -lah'
alias l="eza --icons -lah"
alias v="nvim"
alias e="exit"
alias cl="clear"
alias t="tmux attach || tmux"
alias logout="pkill -KILL -u $USER"
alias wifi="sudo nmtui"
alias test="./gradlew testDebugUnitTest"
alias androidTest="./gradlew connectedAndroidTest"

#Tiledmedia
alias libs="nautilus ~/tiledmedia/TiledmediaCore/Showcase/android/kotlin/flat/app/libs"
alias sdklibs="nautilus ~/tiledmedia/TiledmediaCore/SDK/Android/ClearVRSDK/tiledmediasdk/"
function CleanAndroidCacheTiledmediaSDK() {                                      
   find  ~/tiledmedia/TiledmediaCore/SDK/Android -type d -name ".gradle"  -exec rm -rf {} \;
   find  ~/tiledmedia/TiledmediaCore/SDK -type d -name ".cache"  -exec rm -rf {} \;
   find ~/tiledmedia/TiledmediaCore/SDK -type d -name ".externalNativeBuild"  -exec rm -rf {} \;
} 
alias builders="cd ~/tiledmedia/TiledmediaCore/Tools/BuildCLI && go run . builders monitor"

alias gosdk="~/tiledmedia/TiledmediaCore/SDK"
clog () {
	cpwd=$(pwd)
	gosdk
	cd ../Tools/CoreLogToolbox
	if [[ ! -f "./downloads/$1/clearvr${2}.tmlog" ]]; then
		go run . lookup $1
		mv ./downloads/$1/clearvr.tmlog ./downloads/$1/clearvr${2}.tmlog
	fi
	nvim ./downloads/$1/clearvr${2}.tmlog
	cd ${cpwd}
}

#git
psh() {
  if [ -z "$1" ]; then
    echo "Por favor, proporciona un mensaje de commit."
  else
    git add . && git commit -m "$1" && git push
  fi
}
alias lg='lazygit'

# Set nvim as default editor
export EDITOR="nvim"
export SYSTEMD_EDITOR=nvim

# zoxide
eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions

#Starship
eval "$(starship init zsh)"

# Local ENV vars
source ~/.local_zsh_vars


export GOPATH=~/tiledmedia/TiledmediaCore/Tools/ArchlinuxPKGBUILDs/go-tiledmedia/go
export PATH="$GOPATH/bin:$PATH"
export PATH=$GOPATH:$PATH

export GOPROXY=https://proxy.golang.org,direct
export GOSUMDB=sum.golang.org
