New-Item -Path  "HKLM:\Software\OperationalServices" -Force
Set-ItemProperty -Path "HKLM:\Software\OperationalServices" -Name "ImageName" -Value "CIT-VM" -Type String
Set-ItemProperty -Path "HKLM:\Software\OperationalServices" -Name "ImageVersion" -Value "1.20260414.1" -Type String
