
code --list-extensions > .\vscode\currentState.txt

# foreach ($line in Get-Content .\vscode\extensions.txt) {
#   Write-Output $line
#   code --install-extension $line --force
# }
