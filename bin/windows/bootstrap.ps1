param($type)
. ".\bin\windows\Utils\functions.ps1"

switch ($type) {
  "unlink" {
    . ".\bin\windows\unlink.ps1"
  }
  "programs" {
    . ".\bin\windows\programs.ps1"
  }
  "sym" {
    . ".\bin\windows\symlinks.ps1"
  }
  Default {
    Write-Output "Select, unlink | programs | sym"
  }
}