Import-Module "$home\code\github\dotfiles\powershell\Helpers\Utils.ps1"

function gco { git checkout $args }
function gcob { git checkout -b $args }
function gcod { git checkout development $args }
function gcom { git checkout master $args }
function gs { git status -sb $args }
function gaa { git add --all $args }
function gl { git log $args }
function glo {
  Write-Output "use plog"
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

function dswitch { git checkout "feature/koenv/$args" }
function gmdev { git pull origin development }
function gwmerge { git commit --file .\.git\MERGE_MSG }

function myproject {
  git config user.name "Koen Verburg"
  git config user.email "creativekoen@gmail.com"
}

function cpanel {
  $wtProfile = "Powershell"
  wt -p $wtProfile -d $args `; split-pane -V -p $wtProfile -d $args `; split-pane -H -p $wtProfile -d $args
}

# Folder Jumping
function dot {
  Set-Location "~/code/github/dotfiles"
}

# Yarn aliases
New-Alias y 'yarn' -Scope Global
New-Alias yw 'yarn watch' -Scope Global
New-Alias ys 'yarn serve' -Scope Global
New-Alias yt 'yarn test' -Scope Global
New-Alias yd 'yarn dist' -Scope Global
New-Alias yb 'yarn build' -Scope Global
New-Alias yupgrade 'yarn upgrade-interactive --latest' -Scope Global

# Git Aliases (late 2020 refactor)

New-Alias gf 'git fetch --prune' -Scope Global -PassThru
New-Alias gb 'git branch' -Scope Global
New-Alias unmerged "git branch --no-merged" -Scope Global
New-Alias plog "git log --oneline --decorate" -Scope Global
New-Alias s 'git status -sb' -Scope Global -PassThru