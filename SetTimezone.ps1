$actionScript = "Set-TimeZone -Id 'W. Europe Standard Time'"
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-Command `"$actionScript`""
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName "SetTimeZoneAtStartup" -Action $action -Trigger $trigger -Principal $principal -Force
