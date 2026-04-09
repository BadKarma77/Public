Write-Host "AIB Customization: Init.ps1 started"
#
New-Item -ItemType Directory -Force -Path C:\Temp
New-Item -ItemType Directory -Force -Path C:\Install
#
Remove-LocalGroupMember -Group "FSLogix Profile Include List" -Member "\Jeder"
Remove-LocalGroupMember -Group "FSLogix ODFC Include List" -Member "\Jeder"
#
Write-Host "AIB Customization: execute NeverRed install script"
<#
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}
#
# administrative code here
#>
# from server fileshare (public access not possible)
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -noexit -ExecutionPolicy Bypass -file "\\AZUVM337015\Neverred$\NeverRed.ps1" -ESFile \\AZUVM337015\Neverred$\LastSetting.txt
#
# from azure fileshare (public access not possible)
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -noexit -ExecutionPolicy Bypass -file "\\33storagecn.file.core.windows.net\profilescn\NeverRed\NeverRed.ps1" -ESFile \\33storagecn.file.core.windows.net\profilescn\Neverred\LastSetting.txt
#
Write-Host "AIB Customization: Init.ps1 finished"
