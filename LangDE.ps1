$Version = "LangDE.ps1 v1.2 TS"
Write-Host $Version -ForegroundColor Green
Writelog "* LangDE.ps1 started *" 

#$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

Write-Host "Disable tasks" -ForegroundColor Green
Disable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"

Install-Language -Language de-DE -CopyToSettings
Write-Host "Set-SystemPreferredUILanguage -Language de-DE" -ForegroundColor Green
Set-SystemPreferredUILanguage -Language de-DE
Write-Host "Set-Culture de-DE" -ForegroundColor Green
Set-Culture de-DE
Write-Host "Set-WinHomeLocation -GeoId 94" -ForegroundColor Green
Set-WinHomeLocation -GeoId 94

$OldList = Get-WinUserLanguageList
$NewList = New-WinUserLanguageList -Language de-DE
Write-Host "Set-WinUserLanguageList" -ForegroundColor Green
Set-WinUserLanguageList -LanguageList $NewList -Force

Write-Host "Re-enable tasks" -ForegroundColor Green
Enable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
Enable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"

$stopwatch.Stop()
$elapsedTime = $stopwatch.Elapsed

Writelog "* LangDE.ps1 finished *"
