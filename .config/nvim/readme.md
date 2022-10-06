# Nvim

## Macos
Install nvim (stable)
```
brew install neovim
```

```
curl -o ~/.config/nvim/init.lua --create-dirs https://raw.githubusercontent.com/koenverburg/dotfiles/main/.config/nvim/minimal.lua
```

- Open up nvim, for the first time it will ask you to download packer just type `y` and it will git clone it.
- Close nvim using `:q` followed by an `enter`
- Opening it up again and type `:PackerInstall` this will install of the plugins
- Close and open it again and your are done*



# Unix / Inside a throw-away container

```
docker pull alpine && docker run -it alpine /bin/sh 
```

Install some binaries
```
apk add neovim git alpine-sdk build-base libtool automake m4 autoconf linux-headers unzip ncurses ncurses-dev ncurses-libs ncurses-terminfo clang curl make cmake && rm -rf /var/cache/apk/*

```

*If you run into an issue with fzf not being found this will resolve that
```
cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim && make & cd -
```



