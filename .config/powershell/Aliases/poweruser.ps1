# Yarn aliases
Set-Alias y 'yarn'

function yw { yarn watch }
function ys { yarn serve }
function yt { yarn test -u $args }
function yl { yarn lint }
function yd { yarn dist }
function yb { yarn build }
function yupgrade { yarn upgrade-interactive --latest }

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
