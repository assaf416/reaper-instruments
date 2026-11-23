# Build-BassRig-Assets.ps1
# One-time (maintainer) step: copies the files listed in manifest.txt from your installed Tukan Studios package
# (REAPER\Effects\Tukan, installed with ReaPack) into  vendor\  so this folder is self-contained on your machine.
#
# NOTE: Tukan Studios' repository declares no license, so vendor\ is excluded from git (see .gitignore).
#       Only the manifest (a list of file names), the scripts, the demo project and the docs are meant to be published.

param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$tukan = Join-Path $ReaperResources 'Effects\Tukan'
$plugin = Join-Path $tukan 'Bass Station S2 (Tukan)'
if (-not (Test-Path $plugin)) {
  throw "Bass Station S2 is not installed. In REAPER: Extensions > ReaPack > Import repositories, add`n  https://github.com/TukanStudios/TUKAN_STUDIOS_PLUGINS/raw/main/index2.xml`nthen Browse packages > install 'Series 2' (or search 'Guitar Station')."
}
$vendor = Join-Path $here 'vendor'
$n = 0; $skipped = @()
foreach ($rel in (Get-Content (Join-Path $here 'manifest.txt') | Where-Object { $_.Trim() })) {
  $src = Join-Path $tukan $rel
  if (-not (Test-Path $src)) { $skipped += $rel; continue }
  $dst = Join-Path $vendor $rel
  New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
  Copy-Item $src $dst -Force
  $n++
}
$mb = [math]::Round((Get-ChildItem $vendor -Recurse -File | Measure-Object Length -Sum).Sum / 1MB, 1)
Write-Host "Copied $n files ($mb MB) into $vendor"
if ($skipped.Count) { Write-Warning "$($skipped.Count) manifest files were not found in your Tukan install and were skipped." }
