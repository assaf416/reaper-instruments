# Build-Mellotron-Assets.ps1
# One-time (maintainer) step: copies the DecenTron library into this folder so the project is self-contained.
#   samples\DecenTron\<TapeSet>\<Note>.wav   the 24 tape sets (35 notes each) that Mellotron.jsfx plays
#   resources\DecenTron\                     README, background image and the original .dspreset files
# Source: Documents\DecentSampler\DecenTron 1.0.0  (DecenTron by Stefano "garubi" Garuti, via Decent Samples)

param(
  [string]$Library = (Join-Path $env:USERPROFILE 'Documents\DecentSampler\DecenTron 1.0.0')
)
$here = $PSScriptRoot
if (-not (Test-Path (Join-Path $Library 'Samples'))) { throw "DecenTron library not found at $Library" }

$dstSamples = Join-Path $here 'samples\DecenTron'
$dstRes     = Join-Path $here 'resources\DecenTron'
New-Item -ItemType Directory -Force $dstSamples, $dstRes | Out-Null

Write-Host "Copying tape sets..."
Get-ChildItem (Join-Path $Library 'Samples') -Directory | ForEach-Object {
  $to = Join-Path $dstSamples $_.Name
  New-Item -ItemType Directory -Force $to | Out-Null
  Copy-Item (Join-Path $_.FullName '*.wav') $to -Force
}
# the library also ships a "tape.wav" noise loop next to the sets
Get-ChildItem (Join-Path $Library 'Samples') -File -Filter *.wav | Copy-Item -Destination $dstSamples -Force

Write-Host "Copying resources (README, images, presets)..."
Get-ChildItem $Library -File | Where-Object { $_.Name -ne '.DS_Store' } | Copy-Item -Destination $dstRes -Force

$n = (Get-ChildItem $dstSamples -Recurse -File -Filter *.wav | Measure-Object).Count
$mb = [math]::Round((Get-ChildItem $dstSamples -Recurse -File | Measure-Object Length -Sum).Sum / 1MB)
Write-Host "Done: $n samples, $mb MB in $dstSamples"
