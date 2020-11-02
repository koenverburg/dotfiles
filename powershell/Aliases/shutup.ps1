function teams {
  Start-Process "$env:LOCALAPPDATA\Microsoft\Teams\current\Teams.exe"
}
function teamsk {
  elevateProcess taskkill.exe "/IM Teams.exe /F"
  Clear-Host
}

function mail {
  Start-Process "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
}
function mailk {
  elevateProcess taskkill.exe "/IM OUTLOOK.EXE /F"
  Clear-Host
}

function whats {
  Start-Process "$env:LOCALAPPDATA\WhatsApp\WhatsApp.exe"
}

function whatsk {
  elevateProcess taskkill.exe "/IM WhatsApp.exe /F"
  Clear-Host
}