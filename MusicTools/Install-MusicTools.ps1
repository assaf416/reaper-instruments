# Install-MusicTools.ps1
# Installs the three Music Tools into REAPER (<REAPER>\Effects\MusicTools\): Chord / Tab / Notes Viewer, Solo Generator, Riff Generator
# and the shared MusicLib.jsfx-inc they import. Pure JSFX - nothing else to install. Safe to re-run.
param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$fx = Join-Path $ReaperResources 'Effects\MusicTools'
New-Item -ItemType Directory -Force $fx | Out-Null
Copy-Item (Join-Path $here '*.jsfx') $fx -Force
Copy-Item (Join-Path $here '*.jsfx-inc') $fx -Force
Write-Host "Music Tools installed to $fx"
Write-Host "In REAPER: FX -> Add -> search 'Chord / Tab', 'Solo Generator' or 'Riff Generator'."
Write-Host "Demo project: $(Join-Path $here 'projects\MusicTools_Demo.rpp')   (needs Install-All.ps1 for the instruments it uses)"
