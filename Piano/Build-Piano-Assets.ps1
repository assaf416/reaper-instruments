# Build-Piano-Assets.ps1
# One-time (maintainer) step. For each of the three pianos it
#   1. reads the .dspreset from the Decent Sampler library,
#   2. picks the velocity-layer samples Piano.jsfx uses (and thins the Rhodes),
#   3. COPIES only those samples + all images / readme / preset files into   samples\<key>\...   (original sub-folders kept),
#   4. writes the compact sample maps into                                   maps\<key>_map.txt / <key>_files.txt
#        <key>_map.txt    count, then per sample:  root lo hi loVel hiVel start len gainDb tuneSemis monoFold(0/1)
#        <key>_files.txt  one sample path per line, relative to REAPER's Data folder (Pianos/<key>/...)
# After this, Install-Piano.ps1 needs nothing outside this folder.

param(
  [string]$Library = (Join-Path $env:USERPROFILE 'Documents\DecentSampler')
)
$here = $PSScriptRoot
$inv = [Globalization.CultureInfo]::InvariantCulture
$mapsDir = Join-Path $here 'maps'
$samplesDir = Join-Path $here 'samples'
New-Item -ItemType Directory -Force $mapsDir, $samplesDir | Out-Null

$pianos = @(
  @{ key='MidnightUpright'; dir='Midnight Upright V2 Decent Sampler'; preset='Midnight Upright V2.dspreset'; groups=@('P LAYER','M LAYER','F LAYER'); maxSec=6.0; thin=1 },
  @{ key='KingsUpright';    dir="The King's Upright (DS)";            preset="The King's Upright.dspreset";    groups=@('RR1');                          maxSec=6.0; thin=1 },
  @{ key='FenderRhodes';    dir="Matt's Fender Rhodes  (DS)";         preset="Matt's Fender Rhodes.dspreset";  groups=@('Group 1');                       maxSec=3.5; thin=3 },
  # WurliTzer 1.2 by Daniel Rosenholm (pianobook). The folder/preset names contain a combining umlaut, so they are found by pattern.
  # Its "Line" group is the pickup signal: 64 keys, 3-4 velocity ranges per key (different per key) -> grouped per key, stereo folded to mono to fit memory.
  @{ key='WurliTzer';       dirLike='*rliTzer*';                      presetLike='01*.dspreset';               groups=@('Line');                          maxSec=4.0; thin=2; perKey=$true; mono=1 }
)
$audioExt = '\.(wav|flac|ogg|aif|aiff)$'

function Get-Attrs([string]$s) {
  $h = @{}
  foreach ($m in [regex]::Matches($s, '([A-Za-z0-9_]+)="([^"]*)"')) { $h[$m.Groups[1].Value] = $m.Groups[2].Value }
  $h
}
function To-Db([string]$s) { if (-not $s) { return 0.0 }; [double]::Parse(($s -replace 'dB',''), $inv) }

foreach ($p in $pianos) {
  $src = if ($p.dirLike) { (Get-ChildItem $Library -Directory | Where-Object { $_.Name -like $p.dirLike } | Select-Object -First 1).FullName } else { Join-Path $Library $p.dir }
  if (-not $src -or -not (Test-Path $src)) { Write-Warning "$($p.key): library folder not found - skipped"; continue }
  $presetPath = if ($p.presetLike) { (Get-ChildItem $src -Filter $p.presetLike | Select-Object -First 1).FullName } else { Join-Path $src $p.preset }
  if (-not $presetPath -or -not (Test-Path $presetPath)) { Write-Warning "$($p.key): preset not found - skipped"; continue }
  $dst = Join-Path $samplesDir $p.key

  # parse the preset (regex, because some presets are not strictly valid XML)
  $text = Get-Content $presetPath -Raw -Encoding UTF8
  $rows = New-Object System.Collections.Generic.List[object]
  foreach ($gm in [regex]::Matches($text, '<group\s+([^>]*)>(.*?)</group>', 'Singleline')) {
    $ga = Get-Attrs $gm.Groups[1].Value
    if ($p.groups -notcontains $ga['name']) { continue }
    if ($ga['trigger'] -and $ga['trigger'] -ne 'attack') { continue }
    $gvol = To-Db $ga['volume']
    foreach ($sm in [regex]::Matches($gm.Groups[2].Value, '<sample\s+([^>]*?)/?>')) {
      $a = Get-Attrs $sm.Groups[1].Value
      if (-not $a['path'] -or -not $a['rootNote']) { continue }
      $rel = $a['path'] -replace '/', '\'
      if (-not (Test-Path (Join-Path $src $rel))) { continue }
      $start = [int]$a['start']; $end = [int]$a['end']
      $len = [math]::Min($end - $start, [int]($p.maxSec * 48000))
      if ($len -le 0) { continue }
      $rows.Add([pscustomobject]@{
        root = [int]$a['rootNote']; lo = [int]$a['loNote']; hi = [int]$a['hiNote']
        lv = [int]$a['loVel']; hv = [int]$a['hiVel']; start = $start; len = $len
        gain = (To-Db $a['volume']) + $gvol
        tune = $(if ($a['tuning']) { [double]::Parse($a['tuning'], $inv) } else { 0.0 })
        rel = $rel
        path = 'Pianos/' + $p.key + '/' + ($a['path'] -replace '\\', '/')
      })
    }
  }

  # per velocity layer: optionally thin the roots, then make the key ranges cover 0..127
  $out = New-Object System.Collections.Generic.List[object]
  if ($p.perKey) {
    # velocity ranges differ from key to key: keep every Nth key with all of its layers, key ranges split halfway between kept keys
    $keys = @($rows | Group-Object root | Sort-Object { [int]$_.Name })
    $keptKeys = @(); for ($i = 0; $i -lt $keys.Count; $i++) { if ($i % $p.thin -eq 0 -or $i -eq $keys.Count - 1) { $keptKeys += $keys[$i] } }
    for ($i = 0; $i -lt $keptKeys.Count; $i++) {
      $root = [int]$keptKeys[$i].Name
      $lo = $(if ($i -eq 0) { 0 } else { [int][math]::Floor(([int]$keptKeys[$i-1].Name + $root) / 2) + 1 })
      $hi = $(if ($i -eq $keptKeys.Count - 1) { 127 } else { [int][math]::Floor(($root + [int]$keptKeys[$i+1].Name) / 2) })
      foreach ($r in $keptKeys[$i].Group) { $r.lo = $lo; $r.hi = $hi; $out.Add($r) }
    }
  } else {
  foreach ($layer in ($rows | Group-Object { "$($_.lv)-$($_.hv)" })) {
    $byRoot = $layer.Group | Sort-Object root
    $kept = @(); for ($i = 0; $i -lt $byRoot.Count; $i++) { if ($i % $p.thin -eq 0 -or $i -eq $byRoot.Count - 1) { $kept += $byRoot[$i] } }
    for ($i = 0; $i -lt $kept.Count; $i++) {
      $r = $kept[$i]
      if ($p.thin -gt 1) {
        $r.lo = $(if ($i -eq 0) { 0 } else { [int][math]::Floor(($kept[$i-1].root + $r.root) / 2) + 1 })
        $r.hi = $(if ($i -eq $kept.Count - 1) { 127 } else { [int][math]::Floor(($r.root + $kept[$i+1].root) / 2) })
      } else {
        if ($i -eq 0) { $r.lo = 0 }
        if ($i -eq $kept.Count - 1) { $r.hi = 127 }
      }
      $out.Add($r)
    }
  }
  }

  # copy: every non-audio file (images, readme, presets) + only the audio files the map uses
  $used = @{}; foreach ($r in $out) { $used[(Join-Path $src $r.rel).ToLowerInvariant()] = $true }
  $copied = 0
  Get-ChildItem $src -Recurse -File | Where-Object { $_.Name -ne '.DS_Store' } | ForEach-Object {
    $isAudio = $_.Extension -match $audioExt
    if ($isAudio -and -not $used.ContainsKey($_.FullName.ToLowerInvariant())) { return }
    $to = Join-Path $dst $_.FullName.Substring($src.Length).TrimStart('\')
    New-Item -ItemType Directory -Force (Split-Path $to) | Out-Null
    Copy-Item $_.FullName $to -Force
    if ($isAudio) { $copied++ }
  }

  # maps (LF line endings only: JSFX file_string would otherwise keep a stray CR)
  $enc = New-Object Text.UTF8Encoding($false)
  $mono = if ($p.mono) { 1 } else { 0 }
  $mapLines = @("$($out.Count)") + ($out | % { '{0} {1} {2} {3} {4} {5} {6} {7} {8} {9}' -f $_.root,$_.lo,$_.hi,$_.lv,$_.hv,$_.start,$_.len,$_.gain.ToString('0.###',$inv),$_.tune.ToString('0.###',$inv),$mono })
  [IO.File]::WriteAllText((Join-Path $mapsDir "$($p.key)_map.txt"),   (($mapLines -join "`n") + "`n"), $enc)
  [IO.File]::WriteAllText((Join-Path $mapsDir "$($p.key)_files.txt"), ((@($out | % { $_.path }) -join "`n") + "`n"), $enc)

  $layers = ($out | Select-Object -ExpandProperty lv -Unique).Count
  '{0,-16} {1,3} samples copied, {2} velocity layers' -f $p.key, $copied, $layers
}
$mb = [math]::Round((Get-ChildItem $samplesDir -Recurse -File | Measure-Object Length -Sum).Sum / 1MB)
Write-Host "Done. $mb MB in $samplesDir ; maps in $mapsDir"
