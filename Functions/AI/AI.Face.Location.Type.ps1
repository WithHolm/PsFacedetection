<#
    Image = $Image
    Coordinates = ($ret|New-Rectangle)
    PSTypeName = "PSAI.Face.Location"
#>

update-typedata -MemberType NoteProperty -MemberName "Image" -Value $([pscustomobject]@{PSTypeName="PSAI.Image"}) -TypeName "PSAI.Face.Location" -Force
update-typedata -MemberType NoteProperty -MemberName "Coordinates" -Value [System.Drawing.Rectangle[]] -TypeName "PSAI.Face.Location" -Force