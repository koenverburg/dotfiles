set -g theme_title_use_abbreviated_path yes
set -g theme_show_exit_status yes
set -g fish_prompt_pwd_dir_length 0
set -g theme_color_scheme base16
set -g theme_nerd_fonts yes
set -g theme_date_format "+%a %H:%M"
set -x EDITOR nvim

# $PATH equivalent
# set -U fish_user_paths /usr/local/bin (yarn global bin)

# Aliases
# Vim
alias n=/usr/local/bin/nvim

# tmux
alias mux="tmuxinator"

# Make aliases
alias mt="make test"

# Yarn Aliases
alias ys="yarn serve"
alias yd="yarn dist"
alias ye="yarn export"
alias killbill="rm -f ./yarn.lock;rm -rf ./node_modules;yarn install"

# project jumping
alias dot="cd ~/code/github/dotfiles"

# git aliases # will not working in WSL
alias gf="git fetch --prune"
alias gs="git status -sb"
alias glo="git log --oneline"
alias gl="git log"
alias gpd="git pull"
alias gpo="git push origin"
alias gpuo="git push -u origin"

# docker
alias dlsc="docker container ls -a" # -a because I want to see ALL
alias dlsi="docker images -a" # -a because I want to see ALL
alias dps="docker ps"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"
# alias dockerclean="docker rmi $(docker images --filter "dangling=true" -q --no-trunc)"

# Aliases for ls
alias ll="ls -lh"
alias l="ls -lhA"
alias lsa="ls -a"
alias rm="rm -i"

alias weather="curl http://wttr.in"
#alias t=/usr/local/Cellar/tilt/0.14.1/bin/tilt

