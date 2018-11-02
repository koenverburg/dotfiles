#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )

    # write # and space
    $prompt = Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.PromptHighlightColor

    if (Test-Administrator) {
        $prompt += Write-Prompt -Object "root" -ForegroundColor $sl.Colors.WithForegroundColor
        $prompt += Write-Prompt -Object " in " -ForegroundColor $sl.Colors.PromptForegroundColor
    }
    # write folder
    $dir += Split-Path -leaf -path (Get-Location)

    if ($dir.Equals($env:USERNAME)) {
        $dir = '~'
    }

    $prompt += Write-Prompt -Object "$dir " -ForegroundColor $sl.Colors.AdminIconForegroundColor

    $status = Get-VCSStatus
    if ($status) {
        $sl.GitSymbols.BranchSymbol = [char]::ConvertFromUtf32(0x00e0a0)
        $themeInfo = Get-VcsInfo -status ($status)

        # git project folder
        # $gitRoot = git rev-parse --show-toplevel
        # $prompt += Write-Prompt -Object "at " -ForegroundColor $sl.Colors.PromptForegroundColor
        # $prompt += Write-Prompt -Object "$gitRoot " -ForegroundColor $sl.Colors.AdminIconForegroundColor

        # git changes
        $prompt += Write-Prompt -Object 'on ' -ForegroundColor $sl.Colors.PromptForegroundColor

        $changes = ""
        if ($status.hasWorking) {
            $changes += "+"
        }

        if ($status.HasUntracked) {
            $changes += "?"
        }

        if ($status.AheadBy -gt 0 -and -Not($status.BehindBy -gt 0)) {
            $changes += $GitPromptSettings.BranchAheadStatusSymbol
        }

        if ($status.BehindBy -gt 0 -and -Not($status.AheadBy -gt 0)) {
            $changes += $GitPromptSettings.BranchBehindStatusSymbol
        }

        if ($status.BehindBy -gt 0 -and $status.AheadBy -gt 0) {
            $changes += $GitPromptSettings.BranchBehindAndAheadStatusSymbol
        }

        $changesBlock = ""
        if ($status.hasWorking) {
            $changesBlock = "[$($changes)] "
        }

        $prompt += Write-Prompt -Object "$($sl.GitSymbols.BranchSymbol) $($status.Branch)" -ForegroundColor $themeInfo.BackgroundColor
        $prompt += Write-Prompt -Object " $($changesBlock)" -ForegroundColor $sl.Colors.WithForegroundColor
    }

    # write virtualenv
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object 'inside env:' -ForegroundColor $sl.Colors.PromptForegroundColor
        $prompt += Write-Prompt -Object "$(Get-VirtualEnvName) " -ForegroundColor $themeInfo.VirtualEnvForegroundColor
    }

    # write [time]
    $timeStamp = Get-Date -Format T
    $prompt += Write-Prompt "[$timeStamp]" -ForegroundColor $sl.Colors.PromptForegroundColor

    # check the last command state and indicate if failed
    $foregroundColor = $sl.Colors.PromptHighlightColor
    If ($lastCommandFailed) {
        $foregroundColor = $sl.Colors.CommandFailedIconForegroundColor
    }

    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.WithForegroundColor
    }

    $prompt += Set-Newline
    $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $foregroundColor
    $prompt += ' '
    $prompt
}

function Get-TimeSinceLastCommit {
    return (git log --pretty=format:'%cr' -1)
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.StartSymbol = ''
$sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x279C)
$sl.Colors.PromptHighlightColor = [ConsoleColor]::DarkBlue
$sl.Colors.PromptForegroundColor = [ConsoleColor]::White
$sl.Colors.PromptHighlightColor = [ConsoleColor]::DarkBlue
$sl.Colors.WithForegroundColor = [ConsoleColor]::DarkRed
$sl.Colors.WithBackgroundColor = [ConsoleColor]::Magenta
$sl.Colors.VirtualEnvForegroundColor = [ConsoleColor]::Red
