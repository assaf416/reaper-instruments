# Build-Guitar-Assets.ps1
# One-time (maintainer) step. For each electric guitar it
#   1. reads the .dspreset from the Decent Sampler library,
#   2. picks the sustain samples Guitar.jsfx uses (all velocity layers and round-robins),
#   3. COPIES only those samples + all images / readme / preset files into   samples\<key>\...   (original sub-folders kept),
#   4. writes the compact sample maps into                                   maps\<key>_map.txt / <key>_files.txt
#        <key>_map.txt    count, then per sample:  root lo hi loVel hiVel start len gainDb tuneSemis monoFold(0/1)
#        <key>_files.txt  one sample path per line, relative to REAPER's Data folder (Guitars/<key>/...)
# After this, Install-Guitar.ps1 needs nothing outside this folder.

param(
  [string]$Library = (Join-Path $env:USERPROFILE 'Documents\DecentSampler')
)
$here = $PSScriptRoot
$inv = [Globalization.CultureInfo]::InvariantCulture
$mapsDir = Join-Path $here 'maps'
$samplesDir = Join-Path $here 'samples'
New-Item -ItemType Directory -Force $mapsDir, $samplesDir | Out-Null

# groups: preset groups to use (regex on the group name). Samples copy only for the files the maps use.
$guitars = @(
  @{ key='Strat62';   dir='62 Reissue Stratocaster (DS)'; preset='62 Reissue Stratocaster.dspreset'; groups='^Strat$';              maxSec=4.5 },
  @{ key='AsatClean'; dir='ASAT Classic Variations (DS)'; preset='ACV - ASAT Clean.dspreset';        groups='^ACV ASAT CLEAN RR\d$'; maxSec=5.0 },
  @{ key='AsatDI';    dir='ASAT Classic Variations (DS)'; preset='ACV - ASAT DI.dspreset';           groups='^ACV ASAT DI RR\d$';    maxSec=5.0 }
)
$audioExt = '\.(wav|flac|ogg|aif|aiff)$'

function Get-Attrs([string]$s) {
  $h = @{}
  foreach ($m in [regex]::Matches($s, '([A-Za-z0-9_]+)="([^"]*)"')) { $h[$m.Groups[1].Value] = $m.Groups[2].Value }
  $h
}
function To-Db([string]$s) { if (-not $s) { return 0.0 }; [double]::Parse(($s -replace 'dB',''), $inv) }

foreach ($g in $guitars) {
  $src = Join-Path $Library $g.dir
  $presetPath = Join-Path $src $g.preset
  if (-not (Test-Path $presetPath)) { Write-Warning "$($g.key): preset not found at $presetPath - skipped"; continue }
  $dst = Join-Path $samplesDir $g.key

  $text = Get-Content $presetPath -Raw -Encoding UTF8
  $rows = New-Object System.Collections.Generic.List[object]
  foreach ($gm in [regex]::Matches($text, '<group\s+([^>]*)>(.*?)</group>', 'Singleline')) {
    $ga = Get-Attrs $gm.Groups[1].Value
    if ($ga['name'] -notmatch $g.groups) { continue }
    if ($ga['trigger'] -and $ga['trigger'] -ne 'attack') { continue }
    $gvol = To-Db $ga['volume']
    foreach ($sm in [regex]::Matches($gm.Groups[2].Value, '<sample\s+([^>]*?)/?>')) {
      $a = Get-Attrs $sm.Groups[1].Value
      if (-not $a['path'] -or -not $a['rootNote']) { continue }
      $rel = $a['path'] -replace '/', '\'
      if (-not (Test-Path (Join-Path $src $rel))) { continue }
      $start = [int]$a['start']; $end = [int]$a['end']
      $len = [math]::Min($end - $start, [int]($g.maxSec * 48000))
      if ($len -le 0) { continue }
      $lv = if ($a['loVel']) { [math]::Max(1, [int]$a['loVel']) } else { 1 }
      $hv = if ($a['hiVel']) { [int]$a['hiVel'] } else { 127 }
      $rows.Add([pscustomobject]@{
        root = [int]$a['rootNote']; lo = [int]$a['loNote']; hi = [int]$a['hiNote']
        lv = $lv; hv = $hv; start = $start; len = $len
        gain = (To-Db $a['volume']) + $gvol
        tune = $(if ($a['tuning']) { [double]::Parse($a['tuning'], $inv) } else { 0.0 })
        rel = $rel
        path = 'Guitars/' + $g.key + '/' + ($a['path'] -replace '\\', '/')
      })
    }
  }
  if ($rows.Count -eq 0) { Write-Warning "$($g.key): no samples matched"; continue }

  # cover the whole keyboard: lowest root takes every note below, highest root every note above (round-robins share ranges)
  $minRoot = ($rows | Measure-Object root -Minimum).Minimum; $maxRoot = ($rows | Measure-Object root -Maximum).Maximum
  foreach ($r in $rows) { if ($r.root -eq $minRoot) { $r.lo = 0 }; if ($r.root -eq $maxRoot) { $r.hi = 127 } }
  $out = $rows

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
  $mapLines = @("$($out.Count)") + ($out | % { '{0} {1} {2} {3} {4} {5} {6} {7} {8} 0' -f $_.root,$_.lo,$_.hi,$_.lv,$_.hv,$_.start,$_.len,$_.gain.ToString('0.###',$inv),$_.tune.ToString('0.###',$inv) })
  [IO.File]::WriteAllText((Join-Path $mapsDir "$($g.key)_map.txt"),   (($mapLines -join "`n") + "`n"), $enc)
  [IO.File]::WriteAllText((Join-Path $mapsDir "$($g.key)_files.txt"), ((@($out | % { $_.path }) -join "`n") + "`n"), $enc)

  $layers = ($out | ForEach-Object { "$($_.lv)-$($_.hv)" } | Select-Object -Unique).Count
  $frames = ($out | Measure-Object len -Sum).Sum
  '{0,-10} {1,3} samples copied, {2} velocity band(s), notes {3}-{4}, ~{5:N1}M frames in memory' -f $g.key, $copied, $layers, $minRoot, $maxRoot, ($frames / 1e6)
}
$mb = [math]::Round((Get-ChildItem $samplesDir -Recurse -File | Measure-Object Length -Sum).Sum / 1MB)
Write-Host "Done. $mb MB in $samplesDir ; maps in $mapsDir"
