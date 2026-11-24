# Install-GeneralMidi.ps1
# Installs GeneralMIDI.jsfx into REAPER from this folder:
#   - GeneralMIDI.jsfx -> <REAPER>\Effects\GeneralMIDI\
#   - this folder      -> linked as <REAPER>\Data\GeneralMIDI  (folder junction; it holds samples\ and maps\, nothing is copied)
param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot

function Set-Junction([string]$Link, [string]$Target) {
  if (Test-Path $Link) {
    $item = Get-Item $Link -Force
    if ($item.LinkType -eq 'Junction' -and ($item.Target | Select-Object -First 1) -eq $Target) { return }
    if ($item.LinkType -eq 'Junction') { cmd /c rmdir "`"$Link`"" | Out-Null }
    else { throw "$Link exists and is a real folder - move it away first" }
  }
  New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
}

if (-not (Test-Path (Join-Path $here 'maps\presets.txt'))) { throw "maps\ is missing - run Build-GeneralMidi-Assets.ps1 first" }
$fx = Join-Path $ReaperResources 'Effects\GeneralMIDI'
New-Item -ItemType Directory -Force $fx | Out-Null
Copy-Item (Join-Path $here 'GeneralMIDI.jsfx') $fx -Force
Set-Junction (Join-Path $ReaperResources 'Data\GeneralMIDI') $here

Write-Host "General MIDI installed. In REAPER: FX -> Add -> search 'General MIDI'."
