# Install-BassRig.ps1
# Installs "Bass Station S2" (Tukan Studios) as a bass rig for any bass track or DI:
#   - plugin + its includes, images and impulse responses -> <REAPER>\Effects\BassRig\      (its own folder, so the
#     ReaPack-managed <REAPER>\Effects\Tukan folder is never touched)
#   - FX chain "Bass Rig"  (just the rig, for any bass track or DI) -> <REAPER>\FXChains\
# Files come from  vendor\  if present (made by Build-BassRig-Assets.ps1), otherwise straight from your ReaPack install
# of the Tukan Studios package, using manifest.txt as the file list.

param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$vendor = Join-Path $here 'vendor'
$tukan = Join-Path $ReaperResources 'Effects\Tukan'
$dest = Join-Path $ReaperResources 'Effects\BassRig'

if (Test-Path (Join-Path $vendor 'Bass Station S2 (Tukan)')) { $source = $vendor; $from = 'vendor\' }
elseif (Test-Path (Join-Path $tukan 'Bass Station S2 (Tukan)')) { $source = $tukan; $from = 'your ReaPack install (Effects\Tukan)' }
else {
  Write-Warning "Bass Station S2 is not available on this machine."
  Write-Host "Get it with ReaPack: Extensions > ReaPack > Import repositories, add"
  Write-Host "  https://github.com/TukanStudios/TUKAN_STUDIOS_PLUGINS/raw/main/index2.xml"
  Write-Host "then Browse packages and install the 'Series 2' package, and run this script again."
  exit 1
}

New-Item -ItemType Directory -Force $dest | Out-Null
$n = 0; $skipped = 0
foreach ($rel in (Get-Content (Join-Path $here 'manifest.txt') | Where-Object { $_.Trim() })) {
  $src = Join-Path $source $rel
  if (-not (Test-Path $src)) { $skipped++; continue }
  $dst = Join-Path $dest $rel
  New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
  Copy-Item $src $dst -Force
  $n++
}
Write-Host "Bass Station S2: $n files installed to $dest (from $from)"
& (Join-Path $here "..\Controllers\Patch-Rig.ps1") -File (Join-Path $dest "Bass Station S2 (Tukan)") -Kind bass
if ($skipped) { Write-Warning "$skipped listed files were not found and were skipped." }

# FX chain with just the rig, for any bass track or DI
$chainDir = Join-Path $ReaperResources 'FXChains'
New-Item -ItemType Directory -Force $chainDir | Out-Null
Copy-Item (Join-Path $here 'Bass Rig.RfxChain') $chainDir -Force
Write-Host "FX chain 'Bass Rig' installed. In REAPER: FX -> chain menu -> Bass Rig"
Write-Host "Demo project: $(Join-Path $here 'projects\BassRig_Demo.rpp')"
