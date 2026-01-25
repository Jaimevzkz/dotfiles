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
#Server
alias servicesRestart="~/homelab-services/scripts/update_and_restart.sh"

#Tiledmedia
alias libs="nautilus ~/tiledmedia/TiledmediaCore/Showcase/android/kotlin/flat/app/libs"
alias sdklibs="nautilus ~/tiledmedia/TiledmediaCore/SDK/Android/ClearVRSDK/tiledmediasdk/"
function CleanAndroidCacheTiledmediaSDK() {                                      
   find  ~/tiledmedia/TiledmediaCore/SDK/Android -type d -name ".gradle"  -exec rm -rf {} \;
   find  ~/tiledmedia/TiledmediaCore/SDK -type d -name ".cache"  -exec rm -rf {} \;
   find ~/tiledmedia/TiledmediaCore/SDK -type d -name ".externalNativeBuild"  -exec rm -rf {} \;
} 
#alias mirrorScreen="scrcpy --video-codec=h265 --max-size=384 --max-fps=60 --no-audio --keyboard=uhid -s 340YC10G7W122Y"
alias mirrorScreen="scrcpy --video-codec=h265 --no-audio --keyboard=uhid -s 340YC10G7W122Y"

alias tmwgup="nmcli connection up wg0-tiledmedia"
alias tmwgdown="nmcli connection down wg0-tiledmedia"
alias tmwgshow="nmcli connection show --active"
alias generateAndroidAar="cd /home/vzkz/tiledmedia/TiledmediaCore/SDK && mage -v  build:androidCore3264 && cd ~/tiledmedia/TiledmediaCore/SDK/Android/ClearVRSDK && ./gradlew clean && ./gradlew assembleNative_sdk && cp ~/tiledmedia/TiledmediaCore/SDK/Android/ClearVRSDK/tiledmediasdk/build/outputs/aar/tiledmediasdk-native_sdk-debug.aar ~/tiledmedia/TiledmediaCore/Showcase/android/kotlin/flat/app/libs/"
alias spatialGenerateAar="cd /home/vzkz/tiledmedia/TiledmediaCore/SDK && mage -v  build:androidCore3264 && mage -v build:androidSpatialSDK"
function triggerBuild () {
  cpwd=$(pwd)
  cd ~/tiledmedia/TiledmediaCore/Tools/BuildCLI
  if [ -n "$1" ]
  then
    go run . build $2 --select $1
  else 
    go run . build $2 --select all
  fi
  cd ${cpwd}
}
builders() {
    tmwgup
    cd ~/tiledmedia/TiledmediaCore/Tools/BuildCLI

    if [ -n "$1" ]; then
        go run . builders monitor -a "$1"
    else
        go run . builders monitor
    fi

    cd - >/dev/null
    tmwgdown
}
extract() {
  for archive in "$@"; do
    [ -f "$archive" ] || { echo "File not found: $archive"; continue; }

    case "$archive" in
      *.zip)
        dir="${archive%.zip}"
        mkdir -p "$dir" && unzip "$archive" -d "$dir"
        ;;
      *.tar.gz|*.tgz)
        dir="${archive%.tar.gz}"
        dir="${dir%.tgz}"
        mkdir -p "$dir" && tar -xzf "$archive" -C "$dir"
        ;;
      *)
        echo "Unsupported archive type: $archive"
        ;;
    esac
  done
}

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
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
