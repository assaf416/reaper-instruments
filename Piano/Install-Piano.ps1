# Install-Piano.ps1
# Installs Piano.jsfx into REAPER from this folder:
#   - Piano.jsfx                    -> <REAPER>\Effects\Piano\
#   - maps\*.txt                    -> <REAPER>\Data\Pianos\
#   - samples\<key>                 -> linked as <REAPER>\Data\Pianos\<key>   (folder junctions, nothing is copied)

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

if (-not (Test-Path (Join-Path $here 'maps'))) { throw "maps\ is missing - run Build-Piano-Assets.ps1 first" }
$fx = Join-Path $ReaperResources 'Effects\Piano'
$data = Join-Path $ReaperResources 'Data\Pianos'
New-Item -ItemType Directory -Force $fx, $data | Out-Null

Copy-Item (Join-Path $here 'Piano.jsfx') $fx -Force
Copy-Item (Join-Path $here 'maps\*.txt') $data -Force
Get-ChildItem (Join-Path $here 'samples') -Directory | ForEach-Object { Set-Junction (Join-Path $data $_.Name) $_.FullName }

Write-Host "Piano installed. In REAPER: FX -> Add -> search '416-Piano'."
Write-Host "Demo project: $(Join-Path $here 'projects\Piano_Demo.rpp')"
