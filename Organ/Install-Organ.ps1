# Install-Organ.ps1
# Installs both organ plugins into REAPER's Effects folder (<REAPER>\Effects\Organ\):
#   - OrganSingle.jsfx            the single-manual edition with the custom preset bank
#   - LordOfTheRinks.jsfx         the original plugin by chmaha, unmodified (upper + lower manuals + pedals)
# The organ is pure synthesis, so there are no samples to link.

param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$fx = Join-Path $ReaperResources 'Effects\Organ'
New-Item -ItemType Directory -Force $fx | Out-Null
Copy-Item (Join-Path $here 'OrganSingle.jsfx') $fx -Force
Copy-Item (Join-Path $here 'original\LordOfTheRinks.jsfx') $fx -Force

Write-Host "Organ installed. In REAPER: FX -> Add -> search '416-Organ' (or 'Lord of the Rinks')."
Write-Host "Demo project: $(Join-Path $here 'projects\Organ_Demo.rpp')"
