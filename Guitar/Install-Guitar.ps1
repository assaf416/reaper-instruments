# Install-Guitar.ps1
# Installs Guitar.jsfx into REAPER from this folder:
#   - Guitar.jsfx                   -> <REAPER>\Effects\Guitar\
#   - maps\*.txt                    -> <REAPER>\Data\Guitars\
#   - samples\<key>                 -> linked as <REAPER>\Data\Guitars\<key>   (folder junctions, nothing is copied)

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

if (-not (Test-Path (Join-Path $here 'maps'))) { throw "maps\ is missing - run Build-Guitar-Assets.ps1 first" }
$fx = Join-Path $ReaperResources 'Effects\Guitar'
$data = Join-Path $ReaperResources 'Data\Guitars'
New-Item -ItemType Directory -Force $fx, $data | Out-Null

Copy-Item (Join-Path $here 'Guitar.jsfx') $fx -Force
Copy-Item (Join-Path $here 'maps\*.txt') $data -Force
Get-ChildItem (Join-Path $here 'samples') -Directory | ForEach-Object { Set-Junction (Join-Path $data $_.Name) $_.FullName }

Write-Host "Guitar installed. In REAPER: FX -> Add -> search '416-Guitar'."
Write-Host "Demo project: $(Join-Path $here 'projects\Guitar_Demo.rpp')"
