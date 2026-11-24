# Install-All.ps1
# Installs every instrument in this repository into REAPER (plugins, sample links, sample maps).
# Safe to re-run, and re-run it after moving this folder (it re-points the sample links).
#
#   powershell -ExecutionPolicy Bypass -File .\Install-All.ps1
param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$steps = @(
  'Controllers\Install-Controllers.ps1',
  'Mellotron\Install-Mellotron.ps1',
  'Piano\Install-Piano.ps1',
  'Drums\Install-Drums.ps1',
  'Guitar\Install-Guitar.ps1',
  'Organ\Install-Organ.ps1',
  'GuitarRig\Install-GuitarRig.ps1',
  'BassRig\Install-BassRig.ps1',
  'Synth\Install-Synth.ps1',
  'GeneralMIDI\Install-GeneralMidi.ps1'
)
foreach ($s in $steps) {
  Write-Host "== $s" -ForegroundColor Cyan
  & (Join-Path $here $s) -ReaperResources $ReaperResources
}
Write-Host ""
Write-Host "All instruments installed. Restart REAPER (or Options > Preferences > Plug-ins > JS > Re-scan) if it was open."
Write-Host "Demo projects are in each instrument's 'projects' folder."
