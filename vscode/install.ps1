# foreach ($line in Get-Content .\vscode\extensions.txt) {
#   Write-Output $line
#   code --install-extension $line --force
#   code-insiders.cmd --install-extension $line --force
# }

# code
New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\AppData\Roaming\Code\User\settings.json" -Value ".\vscode\settings.json" -Force >> $null
New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\AppData\Roaming\Code\User\keybindings.json" -Value ".\vscode\keybindings.json" -Force >> $null

# code insiders
New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\AppData\Roaming\Code - Insiders\User\settings.json" -Value ".\vscode\settings.json" -Force >> $null
New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\AppData\Roaming\Code - Insiders\User\keybindings.json" -Value ".\vscode\keybindings.json" -Force >> $null
