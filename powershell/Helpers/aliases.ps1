Import-Module "C:\Users\$($env:USERNAME)\dotfiles\powershell\Helpers\Utils.ps1"

Remove-Alias gs
Remove-Alias gaa
Remove-Alias gp
Remove-Alias gcm
Remove-Alias gc
Remove-Alias gf
Remove-Alias gw
Remove-Alias gpd
Remove-Alias dswitch
Remove-Alias gmdev

function gf { git fetch --prune $args }
function gc { git checkout $args }
function gcd { git checkout development $args }
function gcm { git checkout master $args }
function gcc { git checkout canary $args }
function gs { git status -sb $args }
function gaa { git add --all $args }

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

function team {
  Start-Process -FilePath "C:\Users\koenv\AppData\Local\Microsoft\Teams\Update.exe --processStart 'Teams.exe'"
}

function myproject {
  git config user.name "Koen Verburg"
  git config user.email "creativekoen@gmail.com"
}