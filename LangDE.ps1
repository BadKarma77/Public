# LangDE.ps v.1.1 TS

#$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

Writelog "* LangDE.ps1 started *" 

Disable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"

Install-Language -Language de-DE -CopyToSettings
Set-SystemPreferredUILanguage -Language de-DE
Set-Culture de-DE
Set-WinHomeLocation -GeoId 94

$OldList = Get-WinUserLanguageList
$NewList = New-WinUserLanguageList -Language de-DE
Set-WinUserLanguageList -LanguageList $NewList -Force

Enable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
Enable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"

#$stopwatch.Stop()
#$elapsedTime = $stopwatch.Elapsed

Writelog "* LangDE.ps1 finished *" 
