gci "$PSScriptRoot\Functions" -Recurse -Include "*.public.ps1","*.private.ps1","*.type.ps1"|%{
    . $_.FullName
}

add-type -Path ".\dll\FaceRecognitionDotNet.dll"
Add-Type -AssemblyName "System.Drawing"

$Script:ModuleRoot = $PSScriptRoot