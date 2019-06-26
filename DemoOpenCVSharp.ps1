# add-type -Path "$PSScriptRoot\Packages\OpenCvSharp.dll"

# @("","cplusplus","gpu","MachineLearning","UserInterface","blob")|%{
#     $Filename=[string]::Join(".",(@("OpenCvSharp",$_,"dll")|?{$_}))
#     Write-Output "loading $filename"
#     add-type -Path "$PSScriptRoot\Packages\$filename"
# }


# $Img = [ma]