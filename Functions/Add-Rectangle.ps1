function Add-Rectangle {
    [CmdletBinding()]
    param (
        [System.Drawing.Color]$Color
    )
    $Color
}

Add-Rectangle -Color red

# [System.Drawing.Color]::