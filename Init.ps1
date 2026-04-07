Write-Host "AIB Customization: Init.ps1 started"
#
New-Item -ItemType Directory -Force -Path C:\Temp
New-Item -ItemType Directory -Force -Path C:\Install
Invoke-WebRequest 'https://raw.githubusercontent.com/BadKarma77/Public/refs/heads/main/NeverRed.ps1' -OutFile C:\Install/NeverRed.ps1
#
New-LocalUser -Name "l_admin" -AccountNeverExpires -PasswordNeverExpires $true
Add-LocalGroupMember -Member "l_admin" -Group "Administrators"
#Set-LocalUser -Name "l_admin" -AccountNeverExpires
#Set-LocalUser -Name "l_admin" -PasswordNeverExpires $true
Remove-LocalGroupMember -Group "FSLogix Profile Include List" -Member "\Jeder"
Remove-LocalGroupMember -Group "FSLogix ODFC Include List" -Member "\Jeder"
Add-LocalGroupMember -Group "FSLogix Profile Exclude List" -Member "l_admin"

<#
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}
#
# administrative code here
#>
#
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -noexit -ExecutionPolicy Bypass -file "\\AZUVM337015\Neverred$\NeverRed.ps1" -ESFile \\AZUVM337015\Neverred$\LastSetting.txt
#
Write-Host "AIB Customization: Init.ps1 finished"
