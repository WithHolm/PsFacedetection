function Get-AIModel {
    [CmdletBinding()]
    param (
        
    )
    
    if($Script:AIModel -eq $null)
    {
        return [FaceRecognitionDotNet.Model]::Hog
    }
}

function Set-AIModel {
    [CmdletBinding()]
    param (
        [FaceRecognitionDotNet.Model]$Model
    )
    
    $Script:AIModel = $Model
}