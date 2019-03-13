Import-Module "C:\Users\$($env:USERNAME)\dotfiles\powershell\Helpers\Utils.ps1"

Remove-Alias gs
Remove-Alias gaa
Remove-Alias gp
Remove-Alias gcd
Remove-Alias gcm
Remove-Alias gc
Remove-Alias gf
Remove-Alias gw
Remove-Alias gpd

function gf {
  git fetch --prune $args
}

function gw {
  git commit -m $args
}

function gc {
  git checkout $args
}

function gcd {
  git checkout development $args
}

function gcm {
  git checkout master $args
}

function gs {
  git status -sb $args
}

function gaa {
  git add --all $args
}

function gp {
  $CurrentBranch = Get-Git-CurrentBranch
  git push --set-upstream origin $CurrentBranch
}

function gpd {
  $CurrentBranch = Get-Git-CurrentBranch
  git pull origin $CurrentBranch
}

