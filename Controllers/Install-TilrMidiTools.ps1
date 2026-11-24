# Install-TilrMidiTools.ps1 - downloads Tilr's MIDI Keyvel Filter and GFX MIDI Filter (tiagolr/tilr_jsfx, ReaPack index
# https://raw.githubusercontent.com/tiagolr/tilr_jsfx/master/index.xml) into <REAPER>\Effects\Tilr\ at the commits that index pins.
# Used by the keyboard-split demo. These are third-party files: installed locally, never added to this repository.
param([string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER'))
$dest = Join-Path $ReaperResources 'Effects\Tilr'
New-Item -ItemType Directory -Force $dest | Out-Null
$files = @(
  @('MIDI Keyvel Filter.jsfx', '0318daacf747847e952d7d7bfab01ff9d1b84570'),
  @('GFX MIDI Filter.jsfx',    '766fa15d1159d26bd9bf6c7a1721e9fe0246696e'))
foreach ($f in $files) {
  $url = 'https://github.com/tiagolr/tilr_jsfx/raw/{0}/MIDI/{1}' -f $f[1], ([uri]::EscapeDataString($f[0]))
  Invoke-WebRequest -Uri $url -OutFile (Join-Path $dest $f[0]) -UseBasicParsing
  Write-Host "installed $($f[0])"
}
