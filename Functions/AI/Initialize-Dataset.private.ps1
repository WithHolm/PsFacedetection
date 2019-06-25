function Initialize-AIDataset {
    [CmdletBinding()]
    [OutputType([FaceRecognitionDotNet.FaceRecognition])]
    param (
        [ValidateSet("Face")]
        $Dataset = "Face"
    )
    
    begin {
    }
    
    process {
        Write-Log "Loading '$Dataset' dataset" -Loglevel Verbose
        $DatasetFolder = "$Script:ModuleRoot\Models"
        [FaceRecognitionDotNet.FaceRecognition]::Create("$DatasetFolder\$Dataset")
    }
    
    end {
    }
}