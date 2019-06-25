<#
    [pscustomobject]@{
        Item = $item
        Fr = [FaceRecognitionDotNet.FaceRecognition]::LoadImageFile($Item.FullName,$AIMode)
        Bitmap = [System.Drawing.Image]::FromFile($Item.FullName)
        PSTypeName = "PSAI.Image"
    }
#>
update-typedata -MemberType NoteProperty -MemberName "Item" -Value $null -TypeName "PSAI.Image" -Force
update-typedata -MemberType NoteProperty -MemberName "Bitmap" -Value $null -TypeName "PSAI.Image" -Force
update-typedata -MemberType NoteProperty -MemberName "Fr" -Value $null -TypeName "PSAI.Image" -Force