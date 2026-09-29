# Makes web-sized, numbered copies of phone photos with all metadata (GPS location, camera info) stripped.
# Usage (from the portfolio folder):  powershell -File tools\prepare-photos.ps1
# Reads photos-original\ (git-ignored), writes photos-review\01.jpg, 02.jpg ... in the order listed below.
param(
  [string]$Source = "photos-original",
  [string]$Dest = "photos-review",
  [int]$MaxSide = 1600,
  [int]$Quality = 82
)
Add-Type -AssemblyName PresentationCore, WindowsBase

# Order the photos appeared in the email
$order = @(
  'IMG_5125.JPG', 'IMG_5136.JPG', 'IMG_5283.JPG', 'IMG_5294.JPG', 'IMG_9505.jpeg',
  'D2F00265-3ABF-4C18-AC6B-FCE19C871061.JPG', 'IMG_9561.jpeg', 'IMG_9602.jpeg', 'IMG_9664.jpeg', 'IMG_9726.jpeg',
  'IMG_9799.jpeg', 'IMG_9949.jpeg', 'IMG_0107.jpeg', 'IMG_0115.jpeg', 'IMG_0155.jpeg'
)

New-Item -ItemType Directory -Force $Dest | Out-Null
$i = 0
foreach ($name in $order) {
  $i++
  $path = (Resolve-Path (Join-Path $Source $name)).Path
  $fs = [IO.File]::OpenRead($path)
  $frame = [Windows.Media.Imaging.BitmapDecoder]::Create($fs, 'PreservePixelFormat', 'OnLoad').Frames[0]

  # Phones store rotation as an EXIF flag; apply it so the photo is upright once metadata is removed
  $orientation = 1
  try { $o = $frame.Metadata.GetQuery('/app1/ifd/{ushort=274}'); if ($o) { $orientation = [int]$o } } catch {}
  $angle = switch ($orientation) { 3 { 180 } 6 { 90 } 8 { 270 } default { 0 } }

  $bmp = [Windows.Media.Imaging.BitmapSource]$frame
  if ($angle) { $bmp = New-Object Windows.Media.Imaging.TransformedBitmap($bmp, (New-Object Windows.Media.RotateTransform($angle))) }

  $scale = [Math]::Min(1.0, $MaxSide / [Math]::Max($bmp.PixelWidth, $bmp.PixelHeight))
  if ($scale -lt 1) { $bmp = New-Object Windows.Media.Imaging.TransformedBitmap($bmp, (New-Object Windows.Media.ScaleTransform($scale, $scale))) }

  $enc = New-Object Windows.Media.Imaging.JpegBitmapEncoder
  $enc.QualityLevel = $Quality
  $enc.Frames.Add([Windows.Media.Imaging.BitmapFrame]::Create($bmp))   # new frame = no metadata carried over
  $outPath = Join-Path $Dest ('{0:D2}.jpg' -f $i)
  $out = [IO.File]::Create((Join-Path (Get-Location) $outPath))
  $enc.Save($out); $out.Close(); $fs.Close()
  '{0:D2}  {1,-42} {2}x{3}  rotated {4}  -> {5} KB' -f $i, $name, $bmp.PixelWidth, $bmp.PixelHeight, $angle, [Math]::Round((Get-Item $outPath).Length / 1KB)
}
