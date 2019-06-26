gci "$PSScriptRoot\Functions" -Recurse -Include "*.public.ps1","*.private.ps1","*.type.ps1"|%{
    . $_.FullName
}

add-type -Path ".\packages\FaceRecognitionDotNet.dll"
Add-Type -AssemblyName "System.Drawing"

$Script:ModuleRoot = $PSScriptRoot