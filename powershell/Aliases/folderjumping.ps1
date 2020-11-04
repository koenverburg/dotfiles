# Folder Jumping
function dot {
  Set-Location "~/code/github/dotfiles"
}

# function cpanel {
#   $1 = "--title=DotFiles -d=C:\Users\graff\code\github\dotfiles"
#   wt.exe "$1"
#   # wt -p $wtProfile -d $args `; split-pane -V -p $wtProfile -d $args `; split-pane -H -p $wtProfile -d $args
# }


# function projects {
#   $dotsTitle = "Dotfiles"
#   $dotsPath = $(Resolve-Path ~\code\github\dotfiles).Path

#   $obsidianTitle = "obsidian"
#   $obsidianPath = $(Resolve-Path ~\code\github\dotfiles).Path

#   $tabs = "--title="$($dotsTitle)" -d="$($dotsPath)""

#     # "--title=""$obsidianTitle"" -d=""$obsidianPath""";

#   wt.exe "$($tabs -Join " ``; ")"
#     # --title="site" -d=$(Resolve-Path ~\code\github\koenverburg.dev).Path `;
#     # --title="obsidian" -d=$(Resolve-Path ~\code\github\obsidian).Path `;
#     # --title="Readme" -d=$(Resolve-Path ~\code\github\koenverburg).Path `;
# }
