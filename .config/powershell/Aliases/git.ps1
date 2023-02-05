Import-Module "$home\code\github\dotfiles\.config\powershell\Helpers\Utils.ps1"

# Git Aliases
Set-Alias g 'git'
Set-Alias lg 'lazygit'
function gb { git branch }
function gd { git diff }
function pull { git pull }
function push { git push }
function branch { git branch }
function s { git status -s }
function gf { git fetch --prune }
function grevertlast { git reset --soft HEAD~1 }
function cob { git checkout -b $args }
function cod { git checkout develop $args }
function com { git checkout master $args }
function codm { git checkout development $args }
function comi { git checkout main $args }
function gaa { git add --all $args }

Set-Alias k 'kubectl'
Set-Alias kc 'kubectl create'
Set-Alias kr 'kubectl replace'
Set-Alias krm 'kubectl delete'
Set-Alias kd 'kubectl describe'
Set-Alias kg 'kubectl get'

function co {
  gf;
  git checkout $args;
}

function plog {
  # x09 is a tab
  git log --oneline --pretty=format:"%C(yellow)%h%C(reset)%x09%C(magenta)%an%C(reset)%x09%C(yellow)%ad%C(reset)%x09%s"
}

function gpo {
  $CurrentBranch = Get-Git-CurrentBranch
  git push --set-upstream origin $CurrentBranch
}

function gp {
  $CurrentBranch = Get-Git-CurrentBranch
  git pull origin $CurrentBranch
}

function gw {
  $ticket = Get-Current-Ticket
  if ($null -eq $ticket) {
    git commit -m $args
  }
  else {
    git commit -m "(#$ticket) $args"
  }
}

function fgb {
  git branch -a | fzf --layout=reverse --margin=5 | % { git checkout $_.Trim() }
}

function fg {
  # fzf -m is for multipe files using tab
  git ls-files -m -o --exclude-standard | fzf -m --layout=reverse --margin=5 -m | % { git add $_.Trim() }
  git status -sb;
  cz commit;
}

function myproject {
  git config user.name "Koen Verburg"
  git config user.email "creativekoen@gmail.com"
}

function fp {
  $projects = Get-ChildItem -Name "~/code/github"
  
  $projects | fzf --layout=reverse --header 'Find project' --header-lines=0 | % { cd "~/code/github/$_" } 
}

function kn {
  param (
    $namespace
  )

  if ($namespace -ne $Null) {
    kubectl config set-context --current --namespace=$namespace
  } else {
    $namespaces = kubectl get namespace --no-headers -o custom-columns=":metadata.name"
    $namespaces | fzf --height 40% --layout=reverse --header 'Switch k8s namespace' --header-lines=0 | % { kubectl config set-context --current --namespace=$_ }
  }
}
