
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Properties {
    $Root = $PSScriptRoot
    $Models = Join-Path $Root "Models"
    $Packages = Join-Path $Root "Packages"
    $Packages_exported = Join-Path $Root "dll"
}

Task default -depends nuget,Models

Task nuget {

    write-output "Clean $Packages"
    gci $Packages|remove-item -Recurse -Force

    write-output "Clean $Packages_exported"
    gci $Packages_exported|remove-item -Recurse -Force
    Write-output "Downloading Packages"
    find-package "FaceRecognitionDotNet"|
        install-package -Destination $Packages|
            Out-Null
    
    Write-output "Copying packageDLLs to .\dll"
    Get-ChildItem $Packagedir -Filter "*.dll" -Recurse|Copy-Item -Destination $Packages_exported -Force

    Write-Output "Remove Packages dir"
    get-item $Packages|remove-item -Recurse -Force
}

Task Models {
    Write-Output "Clean $Models"
    $ZipFile = (Join-Path $Models "Github.zip")
    $ZipDir = (Join-Path $Models "Github")
    $Repo =  "https://api.github.com/repos/ageitgey/face_recognition_models/zipball/new-pose-model"
    Write-Output "Setting TLS 1.2"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    Write-Output "Downloading repo"
    Invoke-RestMethod -Method Get -URI $Repo  -OutFile $ZipFile

    Write-output "Unzipping $zipfile"
    unzip $ZipFile -outpath $ZipDir

    Write-Output "Copying Models out"
    get-childitem $ZipDir -Filter "*.dat" -Recurse|copy-item -Destination $Models -Force

    Write-Output "Removing github zip and github folder"
    remove-item $ZipDir -Recurse -Force
    remove-item $ZipFile -Force
}
# Write-output "Downloading models"
# # https://github.com/ageitgey/face_recognition_models/tree/new-pose-model
# $ModelsDir = Join-Path $PSScriptRoot "Models"
# $ZipFile = (Join-Path $ModelsDir "Github.zip")
# $ZipDir = (Join-Path $ModelsDir "Github")
# $Repo =  "https://api.github.com/repos/ageitgey/face_recognition_models/zipball/new-pose-model"
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Invoke-RestMethod -Method Get -URI $Repo  -OutFile $ZipFile

# Write-output "Unzipping $zipfile"
# unzip $ZipFile -outpath $ZipDir

# Write-Output "Copying Models"
# get-childitem $ZipDir -Filter "*.dat" -Recurse|copy-item -Destination $ModelsDir -Force

# Write-Output "Removing github zip and github folder"
# remove-item $ZipDir -Recurse -Force
# remove-item $ZipFile -Force

