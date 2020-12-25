param($type)
. ".\bin\Utils\functions.ps1"

switch ($type) {
  "unlink" {
    . "./bin/unlink.ps1"
  }
  "programs" {
    . ".\bin\programs.ps1"
  }
  "sym" {
    . ".\bin\symlinks.ps1"
  }
  Default {
    Write-Output "All done."
  }
}