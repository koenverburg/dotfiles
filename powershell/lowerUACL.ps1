New-Variable -Name Key
New-Variable -Name PromptOnSecureDesktop_Name
New-Variable -Name ConsentPromptBehaviorAdmin_Name

Function Set-RegistryValue($key, $name, $value, $type = "Dword") {
    If ((Test-Path -Path $key) -Eq $false) { New-Item -ItemType Directory -Path $key | Out-Null }
    Set-ItemProperty -Path $key -Name $name -Value $value -Type $type
}

Function Get-RegistryValue($key, $value) {
    (Get-ItemProperty $key $value).$value
}

$Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$ConsentPromptBehaviorAdmin_Name = "ConsentPromptBehaviorAdmin"
$PromptOnSecureDesktop_Name = "PromptOnSecureDesktop"

Function Get-UACLevel() {
    $ConsentPromptBehaviorAdmin_Value = Get-RegistryValue $Key $ConsentPromptBehaviorAdmin_Name
    $PromptOnSecureDesktop_Value = Get-RegistryValue $Key $PromptOnSecureDesktop_Name
    If ($ConsentPromptBehaviorAdmin_Value -Eq 0 -And $PromptOnSecureDesktop_Value -Eq 0) {
        "The quieter you become the more you are able to hear"
    }
    ElseIf ($ConsentPromptBehaviorAdmin_Value -Eq 5 -And $PromptOnSecureDesktop_Value -Eq 0) {
        "NotIfy me only when apps try to make changes to my computer(do not dim my desktop)"
    }
    ElseIf ($ConsentPromptBehaviorAdmin_Value -Eq 5 -And $PromptOnSecureDesktop_Value -Eq 1) {
        "NotIfy me only when apps try to make changes to my computer(default)"
    }
    ElseIf ($ConsentPromptBehaviorAdmin_Value -Eq 2 -And $PromptOnSecureDesktop_Value -Eq 1) {
        "Always notify"
    }
    Else {
        "Unknown"
    }
}

Function Set-UACLevel() {
    New-Variable -Name PromptOnSecureDesktop_Value
    New-Variable -Name ConsentPromptBehaviorAdmin_Value

    $ConsentPromptBehaviorAdmin_Value = 0
    $PromptOnSecureDesktop_Value = 0

    Set-RegistryValue -Key $Key -Name $ConsentPromptBehaviorAdmin_Name -Value $ConsentPromptBehaviorAdmin_Value
    Set-RegistryValue -Key $Key -Name $PromptOnSecureDesktop_Name -Value $PromptOnSecureDesktop_Value
    Get-UACLevel
    Clear-Host;
}

Set-UACLevel
