# set -g theme_title_use_abbreviated_path yes
# set -g theme_show_exit_status yes
# set -g fish_prompt_pwd_dir_length 0
# set -g theme_color_scheme base16
# set -g theme_nerd_fonts yes
# set -g theme_date_format "+%a %H:%M"
set -g theme_git_worktree_support yes
set -g theme_short_path yes
# set -x EDITOR nvim

set GOPATH /usr/local/bin/go $GOPATH
set PATH /usr/local/bin/go $PATH
set PATH ~/go/bin $PATH
set PATH ~/.cargo/bin $PATH

alias python="python3"

# Set Node Version on startup
if test (uname) = Darwin
 bass source ~/.nvm/nvm.sh ';' nvm use 14.15.4
end
