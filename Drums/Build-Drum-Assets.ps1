# Build-Drum-Assets.ps1
# One-time (maintainer) step. The five kits ship with REAPER's "DSP to JSFX / Plugin Ports" collection
# (one mono FLAC per kit with 5-10 velocity layers per piece; AVL Drumkits by Glen MacArthur, CC-BY-SA 3.0,
# repackaged by chmaha). This script makes the Drums folder self-contained:
#   samples\*.flac          the five kit sample files
#   images\*                kit photos, hit maps, glow overlays
#   licenses\*              each kit's license / README text
#   source-reference\*.jsfx the original kit players the zone tables were read from (GPLv3, kept for credit)
#   maps\<key>_zones.txt    line 1: keyLo keyCount sampleCount zoneCount
#                           then per zone: piece exclusiveGroup mixGroup loVel hiVel start length pan attenuationCb
#   maps\<key>_names.txt    one piece name per line (index = piece)

param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$here = $PSScriptRoot
$inv = [Globalization.CultureInfo]::InvariantCulture
$ports = Join-Path $ReaperResources 'Effects\DSP to JSFX\Plugin Ports'
$deps  = Join-Path $ports 'Dependencies\Drumkits'
if (-not (Test-Path $deps)) { throw "Drum kit files not found at $deps" }

$dirs = @{}
foreach ($n in 'samples','images','licenses','maps','source-reference') { $dirs[$n] = Join-Path $here $n; New-Item -ItemType Directory -Force $dirs[$n] | Out-Null }

# ---- copy samples, images, licenses ----
foreach ($f in (Get-ChildItem $deps -File)) {
  $ext = $f.Extension.ToLowerInvariant()
  if     ($ext -eq '.flac')                  { Copy-Item $f.FullName $dirs['samples']  -Force }
  elseif ($ext -eq '.png' -or $ext -eq '.jpg') { Copy-Item $f.FullName $dirs['images']   -Force }
  elseif ($ext -eq '.txt')                   { Copy-Item $f.FullName $dirs['licenses'] -Force }
}

# key = file prefix, jsfx = source plugin, slot = which zone table inside that plugin (0-based)
$kits = @(
  @{ key='CaptainsKit';      jsfx="Captain's Kit.jsfx"; slot=0 },
  @{ key='LedHead';          jsfx='Led Head.jsfx';      slot=0 },
  @{ key='Goldibops';        jsfx='Goldibops.jsfx';     slot=0 },
  @{ key='GoldibopsHotRods'; jsfx='Goldibops.jsfx';     slot=1 },
  @{ key='BuskStop';         jsfx='Busk Stop.jsfx';     slot=0 }
)
$enc = New-Object Text.UTF8Encoding($false)
foreach ($j in ($kits | % { $_.jsfx } | Select-Object -Unique)) { Copy-Item (Join-Path $ports $j) $dirs['source-reference'] -Force }

foreach ($k in $kits) {
  $src = Join-Path $ports $k.jsfx
  if (-not (Test-Path $src)) { Write-Warning "$($k.key): $src not found - skipped"; continue }
  $t = Get-Content $src -Raw

  $keyLo = [int]([regex]::Match($t, 'KEY_LO\s*=\s*(\d+)').Groups[1].Value)
  $keyN  = [int]([regex]::Match($t, 'KEY_N\s*=\s*(\d+)').Groups[1].Value)

  # all zone tables in the plugin: mem_set_values(ZD [+ expr], numbers...);
  $tables = @()
  foreach ($m in [regex]::Matches($t, 'mem_set_values\(\s*(ZD[^,]*),\s*([^;]*?)\)\s*;', 'Singleline')) {
    $tables += ,@{ nums = @($m.Groups[2].Value -split '[,\s]+' | ? { $_ -ne '' } | % { [double]::Parse($_, $inv) }) }
  }
  if ($tables.Count -le $k.slot) { Write-Warning "$($k.key): zone table $($k.slot) not found"; continue }
  $d = $tables[$k.slot].nums
  $names = ([regex]::Match($t, '#nn_all\s*=\s*"([^"]+)"').Groups[1].Value) -split '\|'

  # decode: per key  n exGroup mixGroup, then n x (loVel hiVel length pan attCb); samples are stored back to back
  $i = 0; $ofs = 0; $lines = New-Object System.Collections.Generic.List[string]
  for ($p = 0; $p -lt $keyN; $p++) {
    $n = [int]$d[$i]; $ex = [int]$d[$i+1]; $g = [int]$d[$i+2]; $i += 3
    for ($z = 0; $z -lt $n; $z++) {
      $lo = [int]$d[$i]; $hi = [int]$d[$i+1]; $len = [int]$d[$i+2]; $pan = $d[$i+3]; $att = $d[$i+4]; $i += 5
      $lines.Add(('{0} {1} {2} {3} {4} {5} {6} {7} {8}' -f $p,$ex,$g,$lo,$hi,$ofs,$len,$pan.ToString('0.###',$inv),$att.ToString('0.###',$inv)))
      $ofs += $len
    }
  }
  $ok = ($i -eq $d.Count)
  if (-not $ok) { Write-Warning "$($k.key): decoded $i of $($d.Count) numbers - table layout differs" }
  # kits that start on note 35 have an extra "stick click" piece that is not in the name list
  if ($names.Count -eq $keyN - 1 -and $keyLo -eq 35) { $names = @('Stick Click') + $names }
  if ($names.Count -ne $keyN) { Write-Warning "$($k.key): $($names.Count) names for $keyN pieces"; $names = 0..($keyN-1) | % { "Piece $($_+1)" } }

  $head = "$keyLo $keyN $ofs $($lines.Count)"
  [IO.File]::WriteAllText((Join-Path $dirs['maps'] "$($k.key)_zones.txt"), ((@($head) + $lines) -join "`n") + "`n", $enc)
  [IO.File]::WriteAllText((Join-Path $dirs['maps'] "$($k.key)_names.txt"), (($names -join "`n") + "`n"), $enc)

  '{0,-17} keys {1}-{2}  {3,3} zones  {4,8:N0} samples  flac:{5}  decoded:{6}' -f $k.key, $keyLo, ($keyLo+$keyN-1), $lines.Count, $ofs, (Test-Path (Join-Path $dirs['samples'] "$($k.key).flac")), $ok
}
$mb = [math]::Round((Get-ChildItem $here -Recurse -File | Where-Object { $_.FullName -match '\\(samples|images)\\' } | Measure-Object Length -Sum).Sum / 1MB, 1)
Write-Host "Done. $mb MB of samples and images in $here"
