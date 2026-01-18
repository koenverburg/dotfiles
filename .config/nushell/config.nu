# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES AND SYSTEM SETUP
# -----------------------------------------------------------------------------

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ($nu.data-dir | path join 'completions')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# -----------------------------------------------------------------------------

# Go configuration
$env.GOROOT = "/opt/homebrew/bin/go"
$env.GOPATH = $env.HOME + "/.local/share/go"
$env.GOMODCACHE = $env.HOME + "/.local/share/go-mod-cache"

# Development tools
$env.EDITOR = "nvim"
$env.BUN_INSTALL = $env.HOME + "/.bun"
$env.PNPM_HOME = "/Users/koenverburg/Library/pnpm"
$env.FNM_PATH = "/opt/homebrew/opt/fnm/bin"

# System configuration
# $env.HOMEBREW_NO_AUTO_UPDATE = "1"
$env.CPPFLAGS = "-I/opt/homebrew/opt/curl/include"
$env.PKG_CONFIG_PATH = "/opt/homebrew/opt/curl/lib/pkgconfig"

# -----------------------------------------------------------------------------
# NUSHELL CONFIGURATION
# -----------------------------------------------------------------------------

$env.STARSHIP_SHELL = "nu"
$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

# History configuration
# $env.config.history = {
#     file: ($nu.home-path | ".nu_history")
#     max_size: 50000
#     sync_on_enter: true
# }


# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES AND SYSTEM SETUP
# -----------------------------------------------------------------------------


# Prompt indicators
$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
$env.PROMPT_COMMAND_RIGHT = ""
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
path add /opt/homebrew/opt/fnm/bin
path add ~/code/tools/typescript-go/built/local

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------

# General aliases
alias ll = ls -l
alias la = ls -a
alias lg = lazygit
alias mg = mergiraf
alias nf = neofetch

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

alias ju = just --justfile ~/.justfile --working-directory .

# -----------------------------------------------------------------------------
# CUSTOM FUNCTIONS
# -----------------------------------------------------------------------------

def --env fp [] {
    let selected = (
        ls ~/code/github
        | append (ls ~/code/2026)
        | append (ls ~/code/2025)
        | append (ls ~/code/2025-h2)
        | append (ls ~/code/2025-h2/checkout.git/tickets)
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
    # ls ~/code/github | append (ls ~/code/2025-h2) | append (ls ~/code/2025-h2/checkout.git/tickets/) | where type == dir

    # Select project
    let selected = (
        ls ~/code/github
        | append (ls ~/code/2025-h2)
        | append (ls ~/code/2025-h2/checkout.git/tickets)
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

# Source theme configuration
source ~/code/github/dotfiles/.config/nushell/black-metal-bathory.nu
source ~/code/github/dotfiles/.config/nushell/prompt_levels.nu

# -----------------------------------------------------------------------------
# BOOTSTRAP RUNTIMES
# -----------------------------------------------------------------------------

source ~/code/github/dotfiles/.config/nushell/git.nu
# source ~/code/github/dotfiles/.config/nushell/go.nu
source ~/code/github/dotfiles/.config/nushell/lua.nu
source ~/code/github/dotfiles/.config/nushell/node.nu
source ~/code/github/dotfiles/.config/nushell/rust.nu

# -----------------------------------------------------------------------------
# EXTERNAL SOURCES AND INITIALIZATION
# -----------------------------------------------------------------------------

set color_config
update terminal
use activate

$env.PROMPT_COMMAND = {||
  let icon = if ($env.LAST_EXIT_CODE == 0) {
    (ansi green) + "#" + (ansi reset) + " "
  } else {
    (ansi red) + "#" + (ansi reset) + " "
  }

  if ($env.__PROMPT_LEVEL.value == 0 or $env.__PROMPT_LEVEL.value == 1) {
    ($icon)
  } else if ($env.__PROMPT_LEVEL.value == 2) {
    ($env.__GIT_INFO_CACHE.value | default "") + $icon
  } else if ($env.__PROMPT_LEVEL.value == 3) {
    let cwd = (pwd) | path basename
    $cwd + " " + ($env.__GIT_INFO_CACHE.value | default "") + " " + $icon
  }
}

$env.PROMPT_COMMAND_RIGHT = {||
  if ($env.__PROMPT_LEVEL.value != 0) {
    ($env.__LUA_INFO_CACHE.value | default "") + ($env.__RUST_INFO_CACHE.value | default "") + ($env.__NODE_INFO_CACHE.value | default "")
  }
}

# Initialize starship
# mkdir ~/.cache/starship
# starship init nu | save -f ~/.cache/starship/init.nu
