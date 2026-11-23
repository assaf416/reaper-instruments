# Install-GuitarRig.ps1
# Installs "Guitar Station S2" (Tukan Studios) as a guitar rig that works with the Guitar instrument:
#   - plugin + its includes, images and impulse responses -> <REAPER>\Effects\GuitarRig\      (its own folder, so the
#     ReaPack-managed <REAPER>\Effects\Tukan folder is never touched)
#   - FX chain "Guitar + Rig"  (Guitar instrument -> Guitar Station S2) -> <REAPER>\FXChains\
# Files come from  vendor\  if present (made by Build-GuitarRig-Assets.ps1), otherwise straight from your ReaPack install
# of the Tukan Studios package, using manifest.txt as the file list.

param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$vendor = Join-Path $here 'vendor'
$tukan = Join-Path $ReaperResources 'Effects\Tukan'
$dest = Join-Path $ReaperResources 'Effects\GuitarRig'

if (Test-Path (Join-Path $vendor 'Guitar Station S2 (Tukan)')) { $source = $vendor; $from = 'vendor\' }
elseif (Test-Path (Join-Path $tukan 'Guitar Station S2 (Tukan)')) { $source = $tukan; $from = 'your ReaPack install (Effects\Tukan)' }
else {
  Write-Warning "Guitar Station S2 is not available on this machine."
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
Write-Host "Guitar Station S2: $n files installed to $dest (from $from)"
if ($skipped) { Write-Warning "$skipped listed files were not found and were skipped." }

# FX chain: the Guitar instrument followed by the rig (needs Guitar\Install-Guitar.ps1 for the first plugin)
$chainDir = Join-Path $ReaperResources 'FXChains'
New-Item -ItemType Directory -Force $chainDir | Out-Null
Copy-Item (Join-Path $here 'Guitar + Rig.RfxChain') $chainDir -Force
Write-Host "FX chain 'Guitar + Rig' installed. In REAPER: FX -> chain menu -> Guitar + Rig"
Write-Host "Demo project: $(Join-Path $here 'projects\GuitarRig_Demo.rpp')"
