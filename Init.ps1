# Init.ps v.1.3 TS

Clear

$Logfile = "C:\_install.log"

function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage -Encoding UTF8
}

Set-Location $HOME

$delfile = "C:\_install.log"
if (Test-Path $delfile) {
    Remove-Item -Path $delfile -Force
}

Remove-Item -Recurse -Force "C:\Install"
Remove-Item -Recurse -Force "C:\Temp"

Writelog "* Init.ps1 started *" 

Set-LocalUser -Name "l_admin" -PasswordNeverExpires $true
Set-LocalUser -Name "l_admin" -AccountNeverExpires

Add-LocalGroupMember -Group "FSLogix Profile Exclude List" -Member "l_admin"
Remove-LocalGroupMember -Group "FSLogix Profile Include List" -Member "\Everyone"
#Remove-LocalGroupMember -Group "FSLogix Profile Include List" -Member "\Jeder"
Remove-LocalGroupMember -Group "FSLogix ODFC Include List" -Member "\Everyone"
#Remove-LocalGroupMember -Group "FSLogix ODFC Include List" -Member "\Jeder" 

Clear

New-Item -ItemType Directory -Force -Path C:\Temp
New-Item -ItemType Directory -Force -Path C:\Install
New-Item -ItemType Directory -Force -Path C:\Install\_Archives

# Set-Location C:\Install

Invoke-WebRequest 'https://raw.githubusercontent.com/BadKarma77/Public/refs/heads/main/LangDE.ps1' -OutFile C:\Install\LangDE.ps1
Invoke-WebRequest 'https://raw.githubusercontent.com/BadKarma77/Public/refs/heads/main/ImageVersion.ps1' -OutFile C:\Install\ImageVersion.ps1
Invoke-WebRequest 'https://raw.githubusercontent.com/BadKarma77/Public/refs/heads/main/ExtractNeverRed.ps1' -OutFile C:\Install\ExtractNeverRed.ps1
Invoke-WebRequest 'https://github.com/Deyda/NeverRed/archive/refs/heads/master.zip' -OutFile C:\Install\_Archives\NeverRed.zip

$ZipPath = "C:\Install\_Archives\NeverRed.zip"
$Destination = "C:\Install\NeverRed"
$ExportFolder = "NeverRed-master"
Invoke-Expression "C:\Install\ExtractNeverRed.ps1 -ZipPath '$ZipPath' -Destination '$Destination' -ExportFolder '$ExportFolder'"

Invoke-Expression "C:\Install\LangDE.ps1"

Set-Location C:\Install\NeverRed
Writelog "* Starting NeverRed.ps1 *" 
# & "C:\install\NeverRed\NeverRed.ps1" -GUIfile LastSetting.txt
C:\install\NeverRed\NeverRed.ps1 -GUIfile LastSetting.txt
Writelog "Init.ps1 finished" 

