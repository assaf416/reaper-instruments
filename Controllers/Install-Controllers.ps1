# Install-Controllers.ps1 - installs the shared controller code every instrument imports, and the controller map.
#   RIControllers.jsfx-inc -> <REAPER>\Effects\        (always updated)
#   controllers.txt        -> <REAPER>\Data\Controllers\   (only created if missing, so a map you learned or edited is kept)
param([string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER'))
$here = $PSScriptRoot
Copy-Item (Join-Path $here 'RIControllers.jsfx-inc') (Join-Path $ReaperResources 'Effects') -Force
$d = Join-Path $ReaperResources 'Data\Controllers'
New-Item -ItemType Directory -Force $d | Out-Null
if (-not (Test-Path (Join-Path $d 'controllers.txt'))) { Copy-Item (Join-Path $here 'controllers.txt') $d }
Write-Host "Controller support installed (map: $(Join-Path $d 'controllers.txt'))"
