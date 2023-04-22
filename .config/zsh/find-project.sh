#!/usr/bin/env bash

selected=$(find ~/code/github ~/code/2023/locker ~/code/2023/showroom ~/code/2023/sportbag -mindepth 1 -maxdepth 1 -type d | fzf --layout=reverse --header 'Find project' --header-lines=0)

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $selected_name -c $selected -n nvim
  exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
  tmux new-session -ds $selected_name -c $selected -n nvim
  tmux new-window -t $selected_name -n cli -c $selected
fi

tmux switch-client -t $selected_name
