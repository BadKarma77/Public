[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,
    [Parameter(Mandatory = $true)]
    [string]$Destination,
    [Parameter(Mandatory = $true)]
    [string]$ExportFolder
)

$Version = "ExtractNeverRed.ps1 v1.2 TS"
Write-Host $Version -ForegroundColor Green
Writelog "* ExtractNeverRed.ps1 started *"

# Write-Host $ZipPath,$Destination,$ExportFolder -ForegroundColor Green
#Writelog $ZipPath,$Destination,$ExportFolder

Expand-Archive -Path $ZipPath -DestinationPath $Destination -Force
Remove-Item -Path $ZipPath -Recurse -Force
Rename-Item -path 'C:\Install\NeverRed-master' -NewName 'C:\Install\NeverRed'
