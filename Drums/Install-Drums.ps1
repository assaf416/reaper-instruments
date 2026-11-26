# Install-Drums.ps1
# Installs Drums.jsfx into REAPER from this folder:
#   - Drums.jsfx          -> <REAPER>\Effects\Drums\
#   - maps\*.txt          -> <REAPER>\Data\Drums\
#   - samples             -> linked as <REAPER>\Data\Drumkits   (folder junction, nothing is copied)

param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot

function Set-Junction([string]$Link, [string]$Target) {
  if (Test-Path $Link) {
    $item = Get-Item $Link -Force
    if ($item.LinkType -eq 'Junction' -and ($item.Target | Select-Object -First 1) -eq $Target) { return }
    if ($item.LinkType -eq 'Junction') { cmd /c rmdir "`"$Link`"" | Out-Null }   # removes only the link, never the target's files
    else { throw "$Link exists and is a real folder - move it away first" }
  }
  New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
}

if (-not (Test-Path (Join-Path $here 'maps'))) { throw "maps\ is missing - run Build-Drum-Assets.ps1 first" }
$fx = Join-Path $ReaperResources 'Effects\Drums'
$data = Join-Path $ReaperResources 'Data\Drums'
New-Item -ItemType Directory -Force $fx, $data | Out-Null

Copy-Item (Join-Path $here 'Drums.jsfx') $fx -Force
Copy-Item (Join-Path $here 'maps\*.txt') $data -Force
Set-Junction (Join-Path $ReaperResources 'Data\Drumkits') (Join-Path $here 'samples')

Write-Host "Drums installed. In REAPER: FX -> Add -> search '416-Drums'."
Write-Host "Demo project: $(Join-Path $here 'projects\Drums_Demo.rpp')"
