#!/bin/sh
# Toggle dark and light themes for firefox, tmux, alacritty,
# and (neo)vim. Either run it from a shell or add a keybinding
# in tmux / alacritty

LIGHTTHEME="githublight"
DARKTHEME="github"

ALACRITTYCONF="~/code/github/dotfiles/.config/alacritty/alacritty.macos.yml"
TMUXCONF="~/code/github/dotfiles/ansible/playbooks/roles/tmux/files/.tmux.conf"

# CURRENT_MODE=$(gsettings get org.gnome.desktop.interface color-scheme)

# Toggle logic based on current mode
if [ "$1" = "dark" ]; then
  # sed -i "s/${DARKTHEME}/${LIGHTTHEME}/" "$ALACRITTYCONF" "$TMUXCONF"
  sed -i "" -e "s#^colors: \*.*#colors: *"${DARKTHEME}"#g" $ALACRITTYCONF
else
  # sed -i "s/${LIGHTTHEME}/${DARKTHEME}/" "$ALACRITTYCONF" "$TMUXCONF"
  sed -i "" -e "s#^colors: \*.*#colors: *"${LIGHTTHEME}"#g" $ALACRITTYCONF
fi

tmux source-file "$TMUXCONF"
