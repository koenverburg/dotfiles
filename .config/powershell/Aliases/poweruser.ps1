# Yarn aliases
Set-Alias y 'yarn'

function pn { pnpm $args }
function yw { yarn watch }
function ys { yarn serve }
function yt { yarn test -u $args }
function yl { yarn lint }
function yd { yarn dist }
function yb { yarn build }
function yupgrade { yarn upgrade-interactive --latest }
function yi {
  yarn install --frozen-lockfile
}

# Alacritty
function apwr {
  alacritty.exe -o shell.program=pwsh.exe
}

function editdot {
  alacritty.exe -o shell.program="pwsh.exe --command cd ~/code/github/dotfiles;nvim"
}

# GO
function grm { go run main.go }

# VIM
Set-Alias vf 'vifm'
Set-Alias n 'nvim'
Set-Alias vim 'nvim'
Set-Alias gvim 'nvim-qt'

# Docker
function dst { # Docker Status
  docker container ls -a;
  docker images -a;
  docker ps;
}

function dcud { docker-compose up -d }
function dcd { docker-compose down }


# Make

Set-Alias m 'make'
Set-Alias k 'kubectl'
