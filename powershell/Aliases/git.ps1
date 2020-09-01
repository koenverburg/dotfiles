Import-Module "$home\code\github\dotfiles\powershell\Helpers\Utils.ps1"

# Git Aliases (late 2020 refactor)
Set-Alias g 'git'
function gb { git branch }
function pull { git pull }
function push { git push }
function branch { git branch }
function s { git status -sb }
function gf { git fetch --prune }
function cob { git checkout -b $args }
function cod { git checkout develop $args }
function codm { git checkout development $args }
function com { git checkout master $args }
function gaa { git add --all $args }

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

function myproject {
  git config user.name "Koen Verburg"
  git config user.email "creativekoen@gmail.com"
}