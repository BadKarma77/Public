# ExtractNeverRed.ps1 v.1.2 TS

param (
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,
    [Parameter(Mandatory = $true)]
    [string]$Destination,
    [Parameter(Mandatory = $true)]
    [string]$ExportFolder
)

Writelog "* ExtractNeverRed.ps1 started *"

# $zipPath = "C:\Install\_Archives\NeverRed.zip"
# $destination = "C:\Install\NeverRed"
# $folderToExtract = "NeverRed-master"

# Write-Host $zipPath "'$zipPath'   '$destination'   '$folderToExtract'" -ForegroundColor Green

$tempPath = Join-Path $env:TEMP "ZipExtractTemp_$(Get-Random)"
New-Item -ItemType Directory -Path $tempPath -Force | Out-Null

try {
    Expand-Archive -Path $zipPath -DestinationPath $tempPath -Force

    $sourceFolder = Join-Path $tempPath $folderToExtract
    
    if (Test-Path $sourceFolder) {
        if (-not (Test-Path $destination)) {
            New-Item -ItemType Directory -Path $destination -Force | Out-Null
        }
        Copy-Item -Path "$sourceFolder\*" -Destination $destination -Recurse -Force
        # Write-Host "Ordner '$folderToExtract' erfolgreich nach '$destination' exportiert" -ForegroundColor Green
        Writelog "Ordner '$folderToExtract' erfolgreich nach '$destination' exportiert"
    } else {
        Write-Error "Der Ordner '$folderToExtract' wurde in der ZIP-Datei nicht gefunden."
        Writelog "Der Ordner '$folderToExtract' wurde in der ZIP-Datei nicht gefunden"
    }
}
finally {
    if (Test-Path $tempPath) {
        Remove-Item -Path $tempPath -Recurse -Force
    }
}
