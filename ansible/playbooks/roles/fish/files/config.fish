# set -g theme_title_use_abbreviated_path yes
# set -g theme_show_exit_status yes
# set -g fish_prompt_pwd_dir_length 0
# set -g theme_color_scheme base16
# set -g theme_nerd_fonts yes
# set -g theme_date_format "+%a %H:%M"
# set -x EDITOR nvim

set ANDROID_HOME ~/tools/cmdline-tools $ANDROID_HOME
set PATH $ANDROID_HOME/emulator $PATH
set PATH $ANDROID_HOME/tools $PATH
set PATH $ANDROID_HOME/tools/bin $PATH
set PATH $ANDROID_HOME/platform-tools $PATH

set PATH /usr/local/go/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/.cargo/bin $PATH
# set PATH ~/tools/cmdline-tools $PATH
