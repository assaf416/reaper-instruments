# Install-Synth.ps1
# Installs RetroSynth.jsfx into REAPER (<REAPER>\Effects\Synth\). The synth is pure synthesis - no samples to link.
param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$fx = Join-Path $ReaperResources 'Effects\Synth'
New-Item -ItemType Directory -Force $fx | Out-Null
Copy-Item (Join-Path $here 'RetroSynth.jsfx') $fx -Force
Write-Host "Synth installed. In REAPER: FX -> Add -> search '416-Synth'."
Write-Host "Demo project: $(Join-Path $here 'projects\Synth_Demo.rpp')"
