# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set oh-my-zsh theme (robbyrussell is default)
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions     # Fish-like autosuggestions
  zsh-syntax-highlighting # Syntax highlighting as you type
)

source $ZSH/oh-my-zsh.sh

##########
# AUTOCOMPLETE CONFIG (Fish-like behavior)
##########

# Accept autosuggestion with Ctrl+Space or End key
bindkey "^ " autosuggest-accept
bindkey "^[[F" autosuggest-accept  # End key

# Partial acceptance with Ctrl+Right Arrow
bindkey "^[[1;5C" forward-word

# Autosuggestion color (gray like fish)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"

# Faster autosuggestions (async mode)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)


##########
# HISTORY
##########

HISTFILE=$HOME/.zsh_history
HISTSIZE=20000        # Reduced from 50k for performance
SAVEHIST=10000        # Reduced from 50k - saves disk space

setopt HIST_IGNORE_DUPS              # Remove duplicates before printing history entry
setopt HIST_FIND_NO_DUPS             # Don't search in already-printed entries
setopt HIST_EXPIRE_DUPS_FIRST         # Expire first those printed more than once
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

##########
# ENV
##########

export HOMEBREW_NO_AUTO_UPDATE=1
export GOPATH=$HOME/go
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export PYENV_ROOT="$HOME/.pyenv"

##########
# PATH
##########

path=(
  /bin
  /sbin
  /usr/bin
  /usr/sbin
  /usr/local/bin
  /usr/local/go/bin      # Go binaries
  /opt/homebrew/bin
  /opt/homebrew/opt/fnm/bin
  $HOME/.local/bin
  $HOME/.cargo/bin       # Cargo binaries (go + rust tooling)
  $HOME/.yarn/bin
  $GOPATH/bin
  $BUN_INSTALL/bin
  $PYENV_ROOT/bin
  $path
)
export PATH

##########
# ALIAS
##########

alias lg='lazygit'
alias mg='mergiraf'
alias ju='just --justfile ~/.justfile --working-directory .'

# Kubernetes
alias k="kubectl"
alias kc="kubectl create"
alias kr="kubectl replace"
alias krm="kubectl delete"
alias kd="kubectl describe"
alias kg="kubectl get"
alias kdr='kubectl --dry-run="client" -o yaml'
alias kdash="k9s --logoless"

# Docker
alias dlsc='docker container ls -a'
alias dlsi='docker images -a'
alias dps='docker ps'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dockerclean='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'

# Recording
alias record='asciinema rec ./recording.cast'
alias showreel='asciinema rec'

##########
# TOOLS
##########

# pyenv - use --no-rehash for faster startup
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - --no-rehash)"
fi

# fnm - explicitly specify zsh
# if command -v fnm >/dev/null 2>&1; then
#   eval "$(fnm env --use-on-cd --shell zsh)"
export HOMEBREW_NO_AUTO_UPDATE=1

export PATH=/opt/homebrew/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH="/usr/local/go/bin":$PATH
export PATH="/usr/local/share/npm/bin:$PATH"

# Bun
export BUN_INSTALL="/Users/verbukoe/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Brew told me to set this
# export PATH="/opt/homebrew/opt/curl/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig"

# completions
[ -s "/Users/verbukoe/.bun/_bun" ] && source "/Users/verbukoe/.bun/_bun"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Wezterm
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# pnpm
export PNPM_HOME="/Users/koenverburg/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Rust
export PATH="$PATH:$HOME/.cargo/env"

# pnpm
export PATH="$PATH:$PNPM_HOME"

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOPATH/bin

# pnpm endfpath=($fpath "/Users/koenverburg/.zfunctions")

# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

eval "$(starship init zsh)"

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

##########
# TENX
##########

function fp() {
  local dir
  dir=$(tenx find-project) && cd "$dir"
}

# >>> aip >>>
export PATH="/Users/verbukoe/.local/bin:$PATH"
fpath=("/Users/verbukoe/.local/share/aip/completions" $fpath)
# <<< aip <<<
# bun
export BUN_INSTALL="~/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/Users/koenverburg/.opencode/bin:$PATH

. "$HOME/.local/bin/env"

export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
