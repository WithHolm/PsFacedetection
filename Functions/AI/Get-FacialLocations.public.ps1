function Get-Facelocations {
    [CmdletBinding()]
    [OutputType('PSAI.Face.Location')]
    param (
        [parameter(
            ParameterSetName="Path",
            Mandatory)]
        [String]$Path,

        [parameter(
            ParameterSetName="Item",
            Mandatory)]
        [System.IO.FileInfo]$Item,

        #Number of times to upsample the image. Higher means better results, but slower
        [int]$Upsamples = 5,

        [FaceRecognitionDotNet.Model]$Model = (Get-FRModel)
    )
    
    begin {
        if($path)
        {
            $Image = Initialize-AIImage -Path $Path -AIMode Rgb
        }
        elseif($item)
        {
            $Image = Initialize-AIImage -Item $Item -AIMode Rgb
        }
        $recog = Initialize-AIDataset
    }
    
    process {
        Write-log "Processing FaceLocations" -Loglevel Verbose
        $ret = @($recog.FaceLocations($Image.Fr,$Upsamples,$Model))
    }
    
    end {
        Write-log "returning $($ret.count) locations" -Loglevel Verbose
        $Return = [pscustomobject]@{
            Image = $Image
            Coordinates = ($ret|New-Rectangle)
            PSTypeName = "PSAI.Face.Location"
        }
        $Return
    }
}