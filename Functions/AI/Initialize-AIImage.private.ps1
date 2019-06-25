function Initialize-AIImage {
    [CmdletBinding()]
    [OutputType("PSAI.Image")]
    param (
        [parameter(
            ParameterSetName="Item",
            Mandatory)]
        [System.IO.FileInfo]$Item,

        [parameter(
            ParameterSetName="Path",
            Mandatory)]
        [String]$Path,

        [parameter(
            ParameterSetName="__Allparametersets",
            Mandatory)]
        [FaceRecognitionDotNet.Mode]$AIMode=[FaceRecognitionDotNet.Mode]::rgb
    )

    if($Path)
    {
        $Item = Get-item $Path
    }
    Write-log "Loading item $($item.Name)" -loglevel Verbose

    [pscustomobject]@{
        Item = $item
        Fr = [FaceRecognitionDotNet.FaceRecognition]::LoadImageFile($Item.FullName,$AIMode)
        Bitmap = [System.Drawing.Image]::FromFile($Item.FullName)
        PSTypeName = "PSAI.Image"
    }
    
}