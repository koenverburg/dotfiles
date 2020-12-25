function Remove-Alias ([string] $AliasName) {
  while (Test-Path Alias:$AliasName) {
    Remove-Item Alias:$AliasName -Force 2> $null
  }
}

function Get-Git-CurrentBranch {
  git symbolic-ref --quiet HEAD *> $null
  if ($LASTEXITCODE -eq 0) {
    return git rev-parse --abbrev-ref HEAD
  }
  else {
    return
  }
}

function Get-Current-Ticket {
  $branch = Get-Git-CurrentBranch
  $pattern = "\/([0-9].*?)\-"

  if ($branch -match $pattern) {
    $project = $matches[1]
    $ticketNumber = $matches[2]

    if ($project -eq "") {
      $ticket = $ticketNumber
    }

    return $ticket
  }
}

function boot {
  $firstTab = '--title "Dotfiles" -p "Powershell" ; split-pane -p "Powershell" ; split-pane -H -p "Powershell"'
  $secondTab = 'new-tab --title "MTS" -p "Powershell" ; split-pane -p "Powershell" ; split-pane -H -p "Powershell"'
  start wt "$firstTab `; $secondTab"
}
