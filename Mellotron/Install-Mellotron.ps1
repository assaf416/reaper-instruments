# Install-Mellotron.ps1
# Installs the Mellotron into REAPER:
#   - Mellotron.jsfx                      -> <REAPER>\Effects\Mellotron\
#   - Lua setup scripts (optional)        -> <REAPER>\Scripts\Mellotron\
#   - samples\DecenTron                   -> linked as <REAPER>\Data\DecenTron   (folder junction, nothing is copied)
# Run it again after moving this folder; it re-points the link.

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

$samples = Join-Path $here 'samples\DecenTron'
if (-not (Test-Path $samples)) { throw "samples\DecenTron is missing - run Build-Mellotron-Assets.ps1 first" }

$fx = Join-Path $ReaperResources 'Effects\Mellotron'
$sc = Join-Path $ReaperResources 'Scripts\Mellotron'
New-Item -ItemType Directory -Force $fx, $sc, (Join-Path $ReaperResources 'Data') | Out-Null
Copy-Item (Join-Path $here 'Mellotron.jsfx') $fx -Force
Copy-Item (Join-Path $here 'scripts\*.lua') $sc -Force
Set-Junction (Join-Path $ReaperResources 'Data\DecenTron') $samples

Write-Host "Mellotron installed. In REAPER: FX -> Add -> search 'Mellotron'."
Write-Host "Demo project: $(Join-Path $here 'projects\Mellotron_Sampler_Demo.rpp')"
