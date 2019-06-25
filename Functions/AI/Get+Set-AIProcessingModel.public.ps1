function Get-AIProcessingModel {
    [CmdletBinding()]
    [OutputType([FaceRecognitionDotNet.Model])]
    param (
        
    )
    
    if([String]::IsNullOrEmpty($Script:AIProcessingModel))
    {
        return [FaceRecognitionDotNet.Model]::Hog
    }
    else 
    {
        $Script:AIProcessingModel
    }
}

function Set-AIProcessingModel {
    [CmdletBinding()]
    param (
        [FaceRecognitionDotNet.Model]$Model
    )
    
    $Script:AIProcessingModel = $Model
}