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
  $pattern = "\/([A-Za-z]{0,4})?-?([0-9]{1,4})"

  if ($branch -match $pattern) {
    $project = $matches[1]
    $ticketNumber = $matches[2]

    if ($project -eq "") {
      $ticket = $ticketNumber
    }
    else {
      $ticket = "$project-$ticketNumber"
    }

    return $ticket
  }
}
