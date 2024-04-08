# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="greenblood"
# ZSH_THEME="alt-jonathan"
# ZSH_THEME="jonathan"
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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
--maxWorkers=50% -u \
--cacheDirectory=./.jest-cache"


# alias ss="bash ~/code/github/dotfiles/.config/tmux/session.sh"
alias keylight="~/code/github/dotfiles/streaming/keylights/keylights"

alias work="timer 25m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -sound Crystal"

alias work60="timer 55m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -sound Crystal"

alias rest="timer 5m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -sound Crystal"

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

# bun completions
[ -s "/Users/verbukoe/.bun/_bun" ] && source "/Users/verbukoe/.bun/_bun"

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Wezterm
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# pnpm
export PNPM_HOME="/Users/koenverburg/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm endfpath=($fpath "/Users/koenverburg/.zfunctions")

# # Set typewritten ZSH as a prompt
# export TYPEWRITTEN_PROMPT_LAYOUT="singleline"
# export TYPEWRITTEN_PROMPT_LAYOUT="pure"
# export TYPEWRITTEN_SYMBOL="$"
# export TYPEWRITTEN_CURSOR="block"

# display_kube_context() {
#   tw_kube_context="$(kubectl config current-context 2> /dev/null)"
#
#   if [[ $tw_kube_context != "" ]]; then
#     echo "($(basename $tw_kube_context))"
#   fi
# }

# export TYPEWRITTEN_LEFT_PROMPT_PREFIX_FUNCTION=display_kube_context

# fpath=($fpath "/Users/koenverburg/.zfunctions")
# autoload -U promptinit; promptinit
# prompt typewritten

eval "$(starship init zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
