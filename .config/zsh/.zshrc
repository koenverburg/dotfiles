# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  # zsh-lazyload
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

##########
# HISTORY
##########

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY     # Immediately append to history file.
setopt EXTENDED_HISTORY       # Record timestamp in history.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Dont write duplicate entries in the history file.
setopt SHARE_HISTORY          # Share history between all sessions.
unsetopt HIST_VERIFY          # Execute commands using history (e.g.: using !$) immediately

##########
# ALIAS
##########

alias tx="tmuxinator"

# (adidas) chk commands
alias diffmain="git diff main --name-only --diff-filter=d '*.js' '*.jsx' '*.ts' '*.tsx'"
alias difflint="git diff main --name-only --diff-filter=d '*.ts' '*.tsx' | xargs eslint_d --fix"
alias difftest="git diff main --name-only --diff-filter=d '*.spec.*' | fzf -m | xargs yarn jest --config=frontend/jest.frontend.json"

alias pn='pnpm'
alias lg='lazygit'
alias fp="bash ~/code/github/dotfiles/.config/zsh/find-project.sh"


# Kubernetes
alias k="kubectl"
alias kc="kubectl create"
alias kr="kubectl replace"
alias krm="kubectl delete"
alias kd="kubectl describe"
alias kg="kubectl get"
alias kdr="kubectl --dry-run=\"client\" -o yaml"
alias kdash="k9s --logoless"

# docker
alias dlsc='docker container ls -a' # -a because I want to see ALL
alias dlsi='docker images -a' # -a because I want to see ALL
alias dps='docker ps'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dockerclean='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'

# Recoding
alias record='asciinema rec ./recoding.cast'
alias showreel='asciinema rec'

# nvim
alias resetnvim='nvim +Deletesession +qall'

alias testfront="TZ=Europe/Amsterdam \
BABEL_ENV='test' \
NODE_ICU_DATA=node_modules/full-icu \
LC_ALL=en_US.utf-8 \
JEST_SUITE_NAME='Frontend_Tests' \
./node_modules/.bin/jest \
--config=frontend/jest.frontend.json \
--maxWorkers=80% -u \
--cacheDirectory=./.jest-cache"

export HOMEBREW_NO_AUTO_UPDATE=1

export PATH=/opt/homebrew/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
# export PATH=$HOME/.bun/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
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


export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(starship init zsh)"
