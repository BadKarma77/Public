[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,
    [Parameter(Mandatory = $true)]
    [string]$Destination,
    [Parameter(Mandatory = $true)]
    [string]$ExportFolder
)

Writelog "* ExtractZip.ps1 started *"

Writelog $ZipPath,$Destination,$ExportFolder

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
        Writelog "Extracted '$folderToExtract' to '$destination'"
    } else {
        # Write-Error "Der Ordner '$folderToExtract' wurde in der ZIP-Datei nicht gefunden."
        Writelog "'$folderToExtract' not found in ZIP"
    }
}
finally {
    if (Test-Path $tempPath) {
        Remove-Item -Path $tempPath -Recurse -Force
    }
}
