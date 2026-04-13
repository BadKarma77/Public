$zipPath = "C:\Install\_Archives\NeverRed.zip"
$destination = "C:\Install\NeverRed"
$folderToExtract = "NeverRed-master"

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
        Write-Host "Ordner '$folderToExtract' erfolgreich exportiert." -ForegroundColor Green
    } else {
        Write-Error "Der Ordner '$folderToExtract' wurde in der ZIP-Datei nicht gefunden."
    }
}
finally {
    if (Test-Path $tempPath) {
        Remove-Item -Path $tempPath -Recurse -Force
    }
}
