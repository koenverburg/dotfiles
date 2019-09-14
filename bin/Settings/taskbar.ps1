#Requires -RunAsAdministrator
$shell = new-object -com "Shell.Application"
$folder = $shell.Namespace('C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_0.3.2171.0_x64__8wekyb3d8bbwe')
$item = $folder.Parsename('WindowsTerminal.exe')

if ($item) {
  Write-Output $item
  $item.InvokeVerb('TaskBarPin')
  # foreach ($verb in $item.Verbs()) {
  #   if ($verb.Name.Replace("&", "") -match "Pin to Start") {
  #     $verb | Get-Member
  #     $item | Get-Member
  #     # $verb.Invoke($verb.Name)
  #     # $item.Invoke($verb.Name)
  #     # $verb.DoIt()
  #   }
  # }
}

# taskbarpin; taskbarunpin
# powershell -NonI -NoP -Command "(New-Object -com Shell.Application).NameSpace('directoryfile').ParseName('programname').InvokeVerb('taskbarpin')"