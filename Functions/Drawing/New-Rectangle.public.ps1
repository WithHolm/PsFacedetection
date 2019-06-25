function New-Rectangle {
    [CmdletBinding(DefaultParameterSetName="XY")]
    [OutputType([System.Drawing.Rectangle])]
    param (
        [parameter(
            ParameterSetName="Location",
            ValueFromPipeline=$true,
            Position=0)]
        [FaceRecognitionDotNet.Location]$Location,

        [parameter(
            ParameterSetName="Dimention",
            Mandatory)]
        [parameter(
            ParameterSetName="XY",
            Mandatory)]
        [int]$Top,

        [parameter(
            ParameterSetName="Dimention",
            Mandatory)]
        [parameter(
            ParameterSetName="XY",
            Mandatory)]
        [int]$Left,

        [parameter(
            ParameterSetName="XY",
            Mandatory)]
        [int]$Right,

        [parameter(
            ParameterSetName="XY",
            Mandatory)]
        [int]$Bottom,

        [parameter(
            ParameterSetName="Dimention",
            Mandatory)]
        [int]$Width,

        [parameter(
            ParameterSetName="Dimention",
            Mandatory)]
        [int]$Height
    )
    
    begin {
    }
    
    process {
        if($PSCmdlet.ParameterSetName -eq "XY")
        {
            $Width = $Right-$Left
            $Height = $Bottom-$Top
        }
        
        if($PSCmdlet.ParameterSetName -eq "Location")
        {
            $Top = $Location.Top
            $Left = $Location.Left
            $Right = $Location.Right
            $Bottom = $Location.Bottom
            $Width = $Right-$Left
            $Height = $Bottom-$Top
        }
        Write-Log -Inputobject "Creating new rectangle, X:$left,Y:$Top,W:$Width,H:$Height"
        [System.Drawing.Rectangle]::new($Left,$Top,$Width,$Height)
    }
    
    end {
    }

    # return [System.Drawing.Rectangle]::new($Left,$Top,$Width,$Height)
}

# [FaceRecognitionDotNet.Location]::new()
