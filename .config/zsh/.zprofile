# ~/.zprofile - Startup performed for shell session only

# ZSH STARTUP
# export ZSH="$HOME/.oh-my-zsh"
# source "${ZSH}/.oh-my-zsh/custom/helpers/zsh_completion.sh" 2>/dev/null || true

# # PATH adjustments
# [[ ! -d "$HOME/go" ]] && export GOPATH=""
# [[ -n "$GOPATH" ]] && eval "$(gpm init)" 2>/dev/null || true

# # Disable beep for quieter terminal
# if [[ $- == *i* ]]; then       # If stdin is a TTY
#     PS1="\[\e]0;%n@%m:%~\a\$\["
# fi

# Performance: Set no-completion if available
# starship uses tab completion by default - this might cause issues with some prompts

# Enable git hooks in project directories
# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWSTASHSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=0  # Skip tracking files for speed
