#Models : https://github.com/ageitgey/face_recognition_models

$VerbosePreference = "Continue"
add-type -Path ".\DLl\FaceRecognitionDotNet.dll"
Add-Type -AssemblyName "System.Drawing"
$Model = [FaceRecognitionDotNet.Model]::Cnn
$imagepath = [System.IO.FileInfo][System.IO.Path]::GetFullPath(".\test\52565936_10216849131394265_7850975418499727360_n.jpg")
# $imagepath.BaseName

Write-Verbose "Loading File"
$Image = [FaceRecognitionDotNet.FaceRecognition]::LoadImageFile($imagepath.FullName,$([FaceRecognitionDotNet.Mode]::Rgb))

Write-Verbose "Loading AI models"
$recog = [FaceRecognitionDotNet.FaceRecognition]::Create(".\models")

Write-verbose "Discovering Facelocation"
$FaceLoc = $recog.FaceLocations($Image,0,$Model)|%{@{Bottom=$_.bottom;Left=$_.Left;Right=$_.Right;Top=$_.Top}}

Write-verbose "Done"
if($FaceLoc.Equals($null))
{
    throw "Could not find face in picture"
}
# else {
#     Write-Verbose "Found $($faceloc.count) faces"
# }

Write-verbose "Loading bitmap image"
$Bitmap = [System.Drawing.Image]::FromFile($imagepath.FullName)
$G = [System.Drawing.Graphics]::FromImage($Bitmap)
# $border = [DlibDotNet.Rectangle]::new($FaceLoc.Left,$FaceLoc.Top,$FaceLoc.Right,$FaceLoc.Bottom)

Write-verbose "Creating pen to draw border"
$pen = [System.Drawing.Pen]::new([System.Drawing.Color]::Red,$Bitmap.Width/200)

Write-Verbose "Processing locations"
foreach($loc in $FaceLoc)
{
    Write-verbose "Creating new border"
    $border = [DlibDotNet.Rectangle]::new($loc.Left,$loc.Top,$loc.Right,$loc.Bottom)

    Write-verbose "Drawing $($pen.Color.Name) border to image"
    $g.DrawRectangle($pen,$loc.Left,$border.Top,$border.Width,$border.Height)

    Write-Verbose "Saving"
    $Bitmap.Save((join-path $imagepath.Directory.FullName "$($imagepath.BaseName)-mod.jpg"),[System.Drawing.Imaging.ImageFormat]::Jpeg)
}

# $gw.Clear([System.Drawing.Color]::White)
# $gw.DrawRectangle($pen,$FaceLoc.Left,$border.Top,$border.Width,$border.Height)

# Write-Verbose "Saving"
# # $White.Save((join-path $imagepath.Directory.FullName "$($imagepath.BaseName)-White.jpg"),[System.Drawing.Imaging.ImageFormat]::Jpeg)
# $Bitmap.Save((join-path $imagepath.Directory.FullName "$($imagepath.BaseName)-mod.jpg"),[System.Drawing.Imaging.ImageFormat]::Jpeg)
<#
_FaceRecognition = FaceRecognition.Create(directory);

                    using (var predictor = ShapePredictor.Deserialize(modelFile))
                    using (var image = FaceRecognition.LoadImageFile(imageFile))
                    using (var mat = Dlib.LoadImageAsMatrix<RgbPixel>(imageFile))
                    using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFile))
                    using (var white = new Bitmap(bitmap.Width, bitmap.Height))
                    using (var g = Graphics.FromImage(bitmap))
                    using (var gw = Graphics.FromImage(white))
                    {
                        var loc = _FaceRecognition.FaceLocations(image).FirstOrDefault();
                        if (loc == null)
                        {
                            Console.WriteLine("No face is detected");
                            return 0;
                        }

                        var b = new DlibDotNet.Rectangle(loc.Left, loc.Top, loc.Right, loc.Bottom);
                        var detection = predictor.Detect(mat, b);

                        using (var p = new Pen(Color.Red, bitmap.Width / 200f))
                        {
                            g.DrawRectangle(p, loc.Left, b.Top, b.Width, b.Height);
                            gw.Clear(Color.White);
                            gw.DrawRectangle(p, loc.Left, b.Top, b.Width, b.Height);
                        }

                        for (int i = 0, parts = (int)detection.Parts; i < parts; i++)
                        {
                            var part = detection.GetPart((uint)i);
                            g.FillEllipse(Brushes.GreenYellow, part.X, part.Y, 15, 15);
                            gw.DrawString($"{i}", SystemFonts.DefaultFont, Brushes.Black, part.X, part.Y);
                        }

                        bitmap.Save("demo.jpg", ImageFormat.Jpeg);
                        white.Save("white.jpg", ImageFormat.Jpeg);
}

#>