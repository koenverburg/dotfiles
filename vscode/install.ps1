foreach ($line in Get-Content .\vscode\extensions.txt) {
  Write-Output $line
  code --install-extension $line --force
  code-insiders.cmd --install-extension $line --force
}
