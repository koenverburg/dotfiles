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
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /opt/homebrew/bin
  $HOME/.cargo/bin       # Cargo binaries (go + rust tooling)
  /usr/local/go/bin      # Go binaries
  $HOME/.yarn/bin
  $GOPATH/bin
  $BUN_INSTALL/bin
  $PNPM_HOME
  /opt/homebrew/opt/fnm/bin
  /Applications/WezTerm.app/Contents/MacOS
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
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
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
