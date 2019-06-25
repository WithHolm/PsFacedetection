
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Properties {
    $Root = $PSScriptRoot
    $Models = Join-Path $Root "Models"
    $Models_Face = (Join-Path $models "Face")
    $Packages = Join-Path $Root "Packages"
}

Task default -depends nuget,Model-Face

Task nuget -preaction{
    write-output "Clean $Packages"
    if(test-path $packages)
    {
        remove-item $Packages -Recurse -Force #|remove-item -Recurse -Force
    }
    write-output "Clean $Packages"
    gci $Packages_exported|remove-item -Recurse -Force
} -action {
    Write-output "Downloading Packages"
    find-package "FaceRecognitionDotNet"|
        install-package -Destination $Packages|
            Out-Null

    find-package "OpenCVSharp"|
        install-package -Destination $Packages|
            Out-Null
    
    Write-output "Copying packageDLLs to packageroot"
    Get-ChildItem $Packagedir -Filter "*.dll" -Recurse|Copy-Item -Destination $Packages -Force
}

task Models -description "Setup Models"{
    New-item $models -ItemType Directory -Force
    Invoke-Task Model-Face
}

Task Model-Face -description "Import face data" -preaction {
    if(!(test-path $Models_Face))
    {
        Write-Output "Creating model folder .\Face"
        New-item $Models_Face -ItemType Directory -Force|Out-Null
    }

    $FaceFiles = gci $Models_Face
    if($FaceFiles.count -gt 0)
    {
        Write-Output "Clean $Models_Face"
        $FaceFiles|remove-item -Recurse -Force
    }
}  -action {
    $ZipFile = (Join-Path $Models_Face "Github.zip")
    $ZipDir = (Join-Path $Models_Face "Github")
    $Repo =  "https://api.github.com/repos/ageitgey/face_recognition_models/zipball/new-pose-model"
    Write-Output "Setting TLS 1.2"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    Write-Output "Downloading repo"
    Invoke-RestMethod -Method Get -URI $Repo  -OutFile $ZipFile

    Write-output "Unzipping $zipfile"
    unzip $ZipFile -outpath $ZipDir

    Write-Output "Copying Models out"
    get-childitem $ZipDir -Filter "*.dat" -Recurse|copy-item -Destination $Models_Face -Force
} -postaction{
    Write-Output "Removing github zip and github folder"
    gci $Models_Face -Exclude "*.dat"|remove-item -Recurse -Force
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

