#$fontFiles = New-Object 'System.Collections.Generic.List[System.IO.FileInfo]'

#function InstallFont($dir) {
  #Get-ChildItem -Path $dir -Recurse -Name -Filter '*Windows Compatible.ttf' | Foreach-Object {$fontFiles.Add($_)}
  #Get-ChildItem -Path $dir -Recurse -Name -Filter '*Windows Compatible.otf' | Foreach-Object {$fontFiles.Add($_)}

  #$fonts = $null
  #foreach ($fontFile in $fontFiles) {
    #if ($PSCmdlet.ShouldProcess($fontFile.Name, "Install Font")) {
      #if (!$fonts) {
        #$shellApp = New-Object -ComObject shell.application
        #$fonts = $shellApp.NameSpace(0x14)
      #}
      #$fonts.CopyHere($fontFile.FullName)
    #}
  #}
#}

[CmdletBinding(SupportsShouldProcess)]
param(
    # Specifies the font name to install.  Default value will install all fonts.
  [Parameter(Position=0)]
  [string[]]
  $FontName = '*'
)

$fontFiles = New-Object 'System.Collections.Generic.List[System.IO.FileInfo]'
foreach ($aFontName in $FontName) {
  Get-ChildItem ".\fonts\patched" -Filter "${aFontName}.ttf" -Recurse | Foreach-Object {$fontFiles.Add($_)}
  Get-ChildItem ".\fonts\patched" -Filter "${aFontName}.otf" -Recurse | Foreach-Object {$fontFiles.Add($_)}
}

$fonts = $null
foreach ($fontFile in $fontFiles) {
  if ($PSCmdlet.ShouldProcess($fontFile.Name, "Install Font")) {
    if (!$fonts) {
      $shellApp = New-Object -ComObject shell.application
      $fonts = $shellApp.NameSpace(0x14)
    }
    $fonts.CopyHere($fontFile.FullName)
  }
}

#InstallFont ".\fonts\patched\FiraCode"
