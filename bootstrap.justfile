# bootstrap.justfile
# Mirrors the setup tasks from Taskfile.yaml, focused on macOS and Linux/Ubuntu

alias s := setup

setup:
    @just _setup-{{ os() }}

_setup-windows:
    echo 'Running command on Windows (not supported)'

_setup-macos:
    mkdir ~/code
    mkdir ~/code/github
    brew install neovim

_setup-linux:
    # base folders
    mkdir ~/code
    mkdir ~/code/github

    # Personal Repos
    # git clone https://github.com/koenverburg/dotfiles.git ~/code/github/dotfiles
    # git clone https://github.com/koenverburg/nvim.git ~/code/github/nvim

    # Neovim
    git clone https://github.com/neovim/neovim.git ~/code/github/neovim --depth=100
    sudo apt-get install ninja-build gettext cmake unzip curl build-essential gcc -y
    cd ~/code/github/neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install

# Languages
alias il := install-languages
alias it := install-tools
alias ia := install-all

install-languages:
    @just _install-rustup
    @just _install-go-{{ os() }}
    @just _install-lua-{{ os() }}

_install-rustup:
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

_install-go-macos:
    brew install go

_install-go-linux:
    sudo apt-get update
    sudo add-apt-repository ppa:longsleep/golang-backports -y
    sudo apt-get update
    sudo apt-get install golang-go -y

_install-lua-macos:
    brew install lua

_install-lua-linux:
    sudo apt-get install lua5.4 liblua5.4-dev luarocks -y

# Tools
install-tools:
    @just _install-lazygit-{{ os() }}
    @just _install-just-{{ os() }}
    @just _install-zellij-{{ os() }}
    @just _install-fnm-{{ os() }}
    @just _install-bun

_install-lazygit-macos:
    brew install lazygit

_install-lazygit-linux:
    go install github.com/jesseduffield/lazygit@latest

_install-just-macos:
    brew install just

_install-just-linux:
    source $HOME/.cargo/env && cargo install just

_install-zellij-macos:
    brew install zellij

_install-zellij-linux:
    source $HOME/.cargo/env && cargo install zellij --locked

_install-fnm-macos:
    brew install fnm

_install-fnm-linux:
    curl -fsSL https://fnm.vercel.app/install | bash

_install-bun:
    curl -fsSL https://bun.sh/install | bash

install-all: setup install-languages install-tools sync-symlinks

# Symlinks
alias sy := sync-symlinks
alias is := init-symlinks

sync-symlinks:
    nu bootstrap.nu {{ os() }}

init-symlinks:
    nu bootstrap.nu {{ os() }} init

remove-symlink TARGET:
    nu bootstrap.nu {{ os() }} remove {{ TARGET }}
