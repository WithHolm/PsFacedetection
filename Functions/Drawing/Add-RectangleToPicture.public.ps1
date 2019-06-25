function Add-RectangleToPicture {
    [CmdletBinding()]
    param (
        [String]$NameModifier = "Mod",

        [parameter(
            ParameterSetName="LocationData",
            ValueFromPipeline=$true,
            Mandatory)]
        [PSTypeName("PSAI.Face.Location")]$Locationdata,


        [ValidateSet("Pink","Red","Aqua","Green","Blue")]
        [string]$color = "Red",

        [int]$RectangleSizePercent = 100 
    )
    
    begin {



        $output=join-path $Locationdata.Image.item.Directory.FullName "$($Locationdata.Image.item.BaseName)-$NameModifier$($Locationdata.Image.item.Extension)"

        # Write-Log "Loading Image $($Locationdata.Image.item.name)"
        $Graphics = [System.Drawing.Graphics]::FromImage($Locationdata.Image.bitmap)
        Write-verbose "Creating red pen to draw borders"
        $Pen = [System.Drawing.Pen]::new([System.Drawing.Color]$color,($RectangleSizePercent/100) * ($Locationdata.Image.bitmap.Width/200))
    }
    
    process {
        Write-Verbose "Processing locations"
        foreach($loc in $Locationdata.Coordinates)
        {
            $Border = [System.Drawing.Rectangle]$loc
            if($RectangleSizePercent -ne 100)
            {
                $NewH = ($RectangleSizePercent/100) * $Border.Height
                $NewW = ($RectangleSizePercent/100) * $Border.Width
                $newx = $Border.X + (($Border.Width - $Neww)/2)
                $newy = $Border.y + (($Border.Height - $NewH)/2)
                # if($newx-lt0)
                # {
                #     $newx = 0
                # }elseif ($newx -gt $Graphics.) {
                    
                # }
                $Border = [System.Drawing.Rectangle]::new($newx,$newy,$NewW,$NewH)
            }
            Write-verbose "Drawing $($pen.Color.Name) border to image"
            $Graphics.DrawRectangle($pen,$Border)
        }
        Write-Verbose "Saving to $output"
        $Locationdata.Image.bitmap.Save($output,[System.Drawing.Imaging.ImageFormat]::Jpeg)
    }
    
    end {
    }
}