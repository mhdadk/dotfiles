# NOTE: this file's path is "$profile", or it is inside the folder "C:\Users\mhdadk\Documents\PowerShell"

# see the following links for details on oh-my-posh
# https://learn.microsoft.com/en-us/windows/terminal/custom-terminal-gallery/powerline-in-powershell
# https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal
# NOTE: make sure you add exclusions to pwsh.exe and oh-my-posh.exe for faster start up times. See
# https://ohmyposh.dev/docs/faq#the-prompt-is-slow-delay-in-showing-the-prompt-between-commands
# https://github.com/JanDeDobbeleer/oh-my-posh/issues/2265#issuecomment-1126722936
# https://support.microsoft.com/en-us/windows/add-an-exclusion-to-windows-security-811816c0-4dfd-af4a-47e4-c301afe13b26#ID0EBF=Windows_11
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "C:\Users\mhdadk\Documents\PowerShell\paradox_modified.omp.json" | Invoke-Expression
#Invoke-Expression (&starship init powershell)

#Import-Module -Name Terminal-Icons

# see https://www.hanselman.com/blog/adding-predictive-intellisense-to-my-windows-terminal-powershell-prompt-with-psreadline
#Import-Module PSReadLine
#Set-PSReadLineOption -PredictionSource History
#Set-PSReadLineOption -PredictionViewStyle ListView
#Set-PSReadLineOption -PredictionViewStyle InlineView
#Set-PSReadLineOption -EditMode Windows
Set-PSReadlineKeyHandler -Key Tab -Function Complete

# turn off the annoying bell sound when tabbing or backspacing
# https://superuser.com/q/1113429/1240879
Set-PSReadlineOption -BellStyle None

# remove virtualenv prepended prompt
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
#$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
#if (Test-Path($ChocolateyProfile)) {
#  Import-Module "$ChocolateyProfile"
#}

# uncomment this so that MSVC is available
# See https://github.com/olegsych/posh-vs for details
#Import-VisualStudioEnvironment

# adjust the columns widths of the ls command so that they are smaller
# OR use lsd command instead
Remove-Item alias:ls

#function ls {
#    Get-ChildItem | Format-Table -AutoSize -Wrap
#}
# See https://help.gnome.org/users/gthumb/stable/gthumb-date-formats.html.en
# for time format codes
function ls {
    $lsdArguments = $args -join ' '
    $lsdCommand = "lsd $lsdArguments --date '+%d-%b-%y %I:%M %p' --blocks permission --blocks size --blocks date --blocks name --header"
    Invoke-Expression $lsdCommand
}

# https://github.com/dahlbyk/posh-git?tab=readme-ov-file#step-2-import-posh-git-from-your-powershell-profile
#Import-Module posh-git
