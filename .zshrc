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
alias h="herdr"
alias logout="pkill -KILL -u $USER"
alias wifi="sudo nmtui"
alias androidTest="./gradlew connectedAndroidTest"
#Server
alias servicesRestart="~/homelab-services/scripts/update_and_restart.sh"

#Tiledmedia
# Resolve the root of the TiledmediaCore git worktree we are currently in.
# Set TM_ROOT to pin a worktree regardless of the current directory.
tmRoot() {
  if [[ -n "$TM_ROOT" ]]; then
    print -r -- "$TM_ROOT"
    return 0
  fi
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "Not inside a git worktree (set TM_ROOT to override)" >&2
    return 1
  }
  if [[ ! -d "$root/SDK" ]]; then
    echo "Worktree $root does not look like TiledmediaCore" >&2
    return 1
  fi
  print -r -- "$root"
}

# Resolve the SDK dir of the git worktree we are currently in
tmSdkDir() {
  local root
  root=$(tmRoot) || return 1
  print -r -- "$root/SDK"
}

libs() {
  local root
  root=$(tmRoot) || return 1
  nautilus "$root/Showcase/android/kotlin/flat/app/libs"
}
sdklibs() {
  local SDK_DIR
  SDK_DIR=$(tmSdkDir) || return 1
  nautilus "$SDK_DIR/Android/ClearVRSDK/tiledmediasdk/"
}

# Open a worktree-relative directory as an Android Studio project (detached).
_tmStudio() {
  local root dir
  root=$(tmRoot) || return 1
  dir="$root/$1"
  if [[ ! -d "$dir" ]]; then
    echo "No such project: $dir" >&2
    return 1
  fi
  echo "Opening $dir"
  (android-studio "$dir" >/dev/null 2>&1 &)
}

iShowcase() { _tmStudio "Showcase/android/kotlin/flat" }
iSdk()      { _tmStudio "SDK/Android/ClearVRSDK" }
iSpatial()  { _tmStudio "Showcase/spatial" }

function CleanAndroidCacheTiledmediaSDK() {
   local SDK_DIR
   SDK_DIR=$(tmSdkDir) || return 1
   find "$SDK_DIR/Android" -type d -name ".gradle"  -exec rm -rf {} \;
   find "$SDK_DIR" -type d -name ".cache"  -exec rm -rf {} \;
   find "$SDK_DIR" -type d -name ".externalNativeBuild"  -exec rm -rf {} \;
}
#alias mirrorScreen="scrcpy --video-codec=h265 --max-size=384 --max-fps=60 --no-audio --keyboard=uhid -s 340YC10G7W122Y"
alias mirrorScreen="scrcpy --video-codec=h265 --no-audio --keyboard=uhid -s 340YC10G7W122Y"

alias tmwgup="nmcli connection up wg0-tiledmedia"
alias tmwgdown="nmcli connection down wg0-tiledmedia"
alias tmwgshow="nmcli connection show --active"

generateAndroidAar() {
  local SDK_DIR
  SDK_DIR=$(tmSdkDir) || return 1

  cd "$SDK_DIR" || return 1
  echo "▶ Building Core AAR"
  mage -v build:androidCore3264
  mage -v build:androidJSUI

  cd "$SDK_DIR/Android/ClearVRSDK" || return 1
  ./gradlew clean
  cd "$SDK_DIR" || return 1
  mage -v build:androidSDK
}
function spatialGenerateAar() {
  local SDK_DIR
  SDK_DIR=$(tmSdkDir) || return 1

  cd "$SDK_DIR" || return 1
  mage -v build:androidCore3264
  if [[ "$1" == "-e" ]]; then
    mage -v build:androidSpatialSDKExperimental
  else
    mage -v build:androidSpatialSDK
  fi
}

function triggerBuild () {
  local cpwd root
  root=$(tmRoot) || return 1
  cpwd=$(pwd)
  cd "$root/Tools/BuildCLI" || return 1

  if [ -n "$1" ]; then
    select="$1"
    shift
  else
    select="all"
  fi

  go run . build "$@" --select "$select" --notify Jaime

  cd "$cpwd" || return 1
}

builders() {
    local root
    root=$(tmRoot) || return 1
    tmwgup
    cd "$root/Tools/BuildCLI" || return 1

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

gosdk() {
  local SDK_DIR
  SDK_DIR=$(tmSdkDir) || return 1
  cd "$SDK_DIR"
}
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
export PATH="$HOME/.local/bin:$PATH"
