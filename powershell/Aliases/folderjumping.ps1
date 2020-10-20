# Folder Jumping
function dot {
  Set-Location "~/code/github/dotfiles"
}

function projects {
  $firstTab = '--title "Dotfiles" -p "Powershell" -d "$HOME\code\github\dotfiles"'
  $secondTab = '--title "site" -p "Powershell" -d "$HOME\code\github\koenverburg.dev"'
  $thirdTab = '--title "Github readme" -p "Powershell" -d "$HOME\code\github\koenverburg"'
  Start-Process wt "$firstTab `; $secondTab `; $thirdTab";
}
