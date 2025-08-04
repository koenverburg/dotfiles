# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES AND SYSTEM SETUP
# -----------------------------------------------------------------------------

# Prompt indicators
$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
$env.STARSHIP_SHELL = "nu"

# Environment variable conversions
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Library and plugin directories
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ($nu.data-dir | path join 'completions')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# -----------------------------------------------------------------------------
# PATH CONFIGURATION
# -----------------------------------------------------------------------------

use std "path add"

# Add paths to PATH
path add /usr/local/bin
path add /usr/local/go/bin
path add /usr/local/share/npm/bin
path add /opt/homebrew/bin
path add /Users/koenverburg/Library/pnpm
path add ~/.bun/bin
path add ~/.yarn/bin
path add ~/.cargo/bin
path add ~/.local/bin
path add ~/.local/share/go/bin

# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# -----------------------------------------------------------------------------

# Go configuration
$env.GOROOT = "/usr/local/go"
$env.GOPATH = "~/.local/share/go"
$env.GOMODCACHE = "~/.local/share/go-mod-cache"

# Development tools
$env.EDITOR = "nvim"
$env.NVM_DIR = "~/.nvm"
$env.BUN_INSTALL = "~/.bun"
$env.PNPM_HOME = "/Users/koenverburg/Library/pnpm"

# System configuration
$env.HOMEBREW_NO_AUTO_UPDATE = "1"
$env.CPPFLAGS = "-I/opt/homebrew/opt/curl/include"
$env.PKG_CONFIG_PATH = "/opt/homebrew/opt/curl/lib/pkgconfig"

# -----------------------------------------------------------------------------
# NUSHELL CONFIGURATION
# -----------------------------------------------------------------------------

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

# History configuration
# $env.config.history = {
#     file: ($nu.home-path | ".nu_history")
#     max_size: 50000
#     sync_on_enter: true
# }

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------

# Git aliases
alias diffmain = git diff main --name-only --diff-filter=d '*.js' '*.jsx' '*.ts' '*.tsx'
alias difflint = git diff main --name-only --diff-filter=d '*.ts' '*.tsx' | xargs eslint_d --fix
alias difftest = git diff main --name-only --diff-filter=d '*.spec.*' | fzf -m | xargs yarn jest --config=frontend/jest.frontend.json

# General aliases
alias ll = ls -l
alias la = ls -a
alias lg = lazygit
alias nf = neofetch
alias pn = pnpm
alias fp = bash ~/code/github/dotfiles/.config/zsh/find-project.sh

# Kubernetes aliases
alias k = kubectl
alias kc = kubectl create
alias kr = kubectl replace
alias krm = kubectl delete
alias kd = kubectl describe
alias kg = kubectl get
alias kdr = kubectl --dry-run=client -o yaml
alias kdash = k9s --logoless

# Docker aliases
alias dlsc = docker container ls -a
alias dlsi = docker images -a
alias dps = docker ps
alias dcud = docker-compose up -d
alias dcd = docker-compose down
alias dockerclean = docker rmi (docker images --filter "dangling=true" -q --no-trunc)

# Recording aliases
alias record = asciinema rec ./recoding.cast
alias showreel = asciinema rec

# Neovim aliases
alias resetnvim = nvim +Deletesession +qall

# Test aliases
alias testfront = TZ=Europe/Amsterdam BABEL_ENV='test' NODE_ICU_DATA=node_modules/full-icu LC_ALL=en_US.utf-8 JEST_SUITE_NAME='Frontend_Tests' ./node_modules/.bin/jest --config=frontend/jest.frontend.json --maxWorkers=80% -u --cacheDirectory=./.jest-cache

# -----------------------------------------------------------------------------
# CUSTOM FUNCTIONS
# -----------------------------------------------------------------------------

def --env fp [] {
    let selected = (
        ls ~/code/github
        | where type == dir
        | get name
        | str join "\n"
        | fzf --layout=reverse --header 'Find project' --header-lines=0
    )
    if ($selected | is-empty) {
        return
    }
    try {
        cd $selected
        echo $"Changed to ($selected)"
    } catch {
        echo $"Failed to change directory to ($selected)"
    }
}

def fps [] {
    # Select project
    let selected = (
        ls ~/code/github
        | where type == dir
        | get name
        | str join "\n"
        | fzf --layout=reverse --header 'Find project' --header-lines=0
    )
    if ($selected | is-empty) {
        return
    }
    cd $selected

    # Select layout
    let layout_dir = "~/.config/zellij/layouts"
    let available_layouts = (
        ls ($layout_dir | path expand)
        | where type == file and name =~ ".kdl$"
        | get name
        | each { |layout| $layout | path basename | str replace ".kdl" "" }
    )

    let selected_layout = (
        $available_layouts
        | str join "\n"
        | fzf --layout=reverse --header 'Select layout' --header-lines=0
        | str trim
    )
    if ($selected_layout | is-empty) {
        return
    }

    let selected_name = ($selected | path basename | str replace -a "." "_")

    # Get all sessions
    let sessions = (
        do { zellij ls -n } | complete | get stdout | lines | each { |line| $line | str trim } | where $it != ""
    )

    # Check if any session with our name exists
    let matching_sessions = ($sessions | where { |session| $session | str contains $selected_name })
    let session_exists = ($matching_sessions | length) > 0

    # Check if we're currently inside zellij
    let in_zellij = ($env.ZELLIJ? | is-not-empty)

    if $session_exists {
        # Check if the existing session is exited
        let session_exited = ($matching_sessions | any { |session| $session | str contains "EXITED" })

        if $session_exited {
            print $"Session ($selected_name) exited, cleaning up..."
            zellij delete-session $selected_name --force
            print $"Creating new session with layout ($selected_layout)"
            if $in_zellij {
                zellij action attach --name $selected_name --layout $selected_layout
            } else {
                zellij --session $selected_name --new-session-with-layout $selected_layout
            }
        } else {
            print $"Session ($selected_name) exists and is alive..."
            if $in_zellij {
                print "Switching to session"
                zellij action switch-session $selected_name
            } else {
                print "Attaching to session"
                zellij attach $selected_name
            }
        }
    } else {
        print $"No session found, creating new one with layout ($selected_layout)..."
        if $in_zellij {
            zellij action new-session --name $selected_name --layout $selected_layout
        } else {
            zellij --session $selected_name --new-session-with-layout $selected_layout
        }
    }
}

def servermode [] {
    let name = "servermode"
    let layout = "servermode"

    let sessions = (
        do { zellij ls -n } | complete | get stdout | lines | each { |line| $line | str trim } | where $it != ""
    )

    # Check if any session with our name exists
    let matching_sessions = ($sessions | where { |session| $session | str contains $name })
    let session_exists = ($matching_sessions | length) > 0

    let in_zellij = ($env.ZELLIJ? | is-not-empty)

    if $session_exists {
        # Check if the existing session is exited
        let session_exited = ($matching_sessions | any { |session| $session | str contains "EXITED" })

        if $session_exited {
            print $"Session ($name) exited, cleaning up..."
            zellij delete-session $name --force
            print $"Creating new session with layout ($layout)"
            if $in_zellij {
                zellij action -c $name --layout $layout
            } else {
                zellij --session $name --new-session-with-layout $layout
            }
        } else {
            print $"Session ($name) exists and is alive..."
            if $in_zellij {
                print "Switching to session"
                zellij action switch-session $name
            } else {
                print "Attaching to session"
                zellij attach $name
            }
        }
    } else {
        print $"No session found, creating new one with layout ($layout)..."
        if $in_zellij {
            zellij action new-session --name $name --layout $layout
        } else {
            zellij --session $name --new-session-with-layout $layout
        }
    }
}

# -----------------------------------------------------------------------------
# EXTERNAL SOURCES AND INITIALIZATION
# -----------------------------------------------------------------------------

# Source theme configuration
source ~/.config/nushell/black-metal-bathory.nu

set color_config
update terminal
use activate

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Initialize starship
# mkdir ~/.cache/starship
# starship init nu | save -f ~/.cache/starship/init.nu
