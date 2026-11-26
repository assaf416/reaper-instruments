# Build-MusicToolsDemo.ps1
# Writes projects\MusicTools_Demo.rpp: the Hendrix-style riff in G at 80 BPM, a generated solo over it and the chord viewer.
#   Track 1  Riff Generator (Hendrix preset, output GUITAR only)  -> Guitar sampler           the guitar riff
#   Track 2  Riff Generator (Hendrix preset, output BASS only)    -> Guitar sampler (bass)    the bass line  (same preset + seed = same riff)
#   Track 3  Solo Generator (bars 5-8, blues, G)            -> Retro Synth (lead)       a solo in the second half of the song
#   Track 4  Chord / Tab / Notes Viewer on a MIDI item with the chords (Piano) - shows the chord chart while it plays
# Needs Install-All.ps1 (Guitar samples, Retro Synth, Piano) and Install-MusicTools.ps1.
#   powershell -ExecutionPolicy Bypass -File .\Build-MusicToolsDemo.ps1            -> projects\MusicTools_Demo.rpp
#   ... -ShowFx                                                                   -> also opens the plugin windows (used for screenshots)
param(
  [string]$Out = (Join-Path $PSScriptRoot 'projects\MusicTools_Demo.rpp'),
  [switch]$ShowFx
)
$PPQ = 960; $BPM = 80; $BARS = 8
$dash = { param($n) ((1..$n | ForEach-Object { '-' }) -join ' ') }

# chords of the viewer track as MIDI notes: G7#9 | C9 | G7#9 | D9 C9  (twice)
$G7s9 = @(43, 53, 59, 70); $C9 = @(48, 58, 62, 64); $D9 = @(50, 60, 64, 66)
$chordNotes = @()
for ($rep = 0; $rep -lt 2; $rep++) {
  $bt0 = $rep * 4
  foreach ($nt in $G7s9) { $chordNotes += ,@($nt, 90, (($bt0 + 0) * 4), 3.7) }
  foreach ($nt in $C9)   { $chordNotes += ,@($nt, 90, (($bt0 + 1) * 4), 3.7) }
  foreach ($nt in $G7s9) { $chordNotes += ,@($nt, 90, (($bt0 + 2) * 4), 3.7) }
  foreach ($nt in $D9)   { $chordNotes += ,@($nt, 90, (($bt0 + 3) * 4), 1.8) }
  foreach ($nt in $C9)   { $chordNotes += ,@($nt, 90, ((($bt0 + 3) * 4) + 2), 1.8) }
}
function MidiSource($notes) {
  $ev = New-Object System.Collections.Generic.List[object]
  foreach ($n in $notes) {
    $t = [int]($n[2] * $PPQ); $len = [int]($n[3] * $PPQ)
    $ev.Add([pscustomobject]@{ t = $t; s = 0x90; n = $n[0]; v = $n[1] }); $ev.Add([pscustomobject]@{ t = $t + $len; s = 0x80; n = $n[0]; v = 0 })
  }
  $sorted = $ev | Sort-Object t, @{ e = { if ($_.s -eq 0x80) { 0 } else { 1 } } }, n
  $prev = 0; $lines = New-Object System.Collections.Generic.List[string]
  foreach ($x in $sorted) { $lines.Add(('        E {0} {1:x2} {2:x2} {3:x2}' -f ($x.t - $prev), $x.s, $x.n, $x.v)); $prev = $x.t }
  $lines -join "`n"
}
# Riff Generator sliders: preset style key mode bars tempo density variation humanize seed output sync startbar guitarLvl bassLvl channel
function RiffFx($output) { 'MusicTools/RiffGenerator.jsfx', ('0 0 4 7 8 80 0.85 0.55 0.4 1 ' + $output + ' 1 1 1 1 1 ' + (& $dash 40)) }
$tracks = @(
  @{ name = 'Riff Generator - Guitar (Hendrix style, G, 80 BPM)'; vol = 0.45; pan = -0.2
     fx = @((RiffFx 1), @('Guitar/Guitar.jsfx', ('0 0.35 0.8 0.5 0.3 380 0.4 1 2 1 0.5 1 ' + (& $dash 52)))) },
  @{ name = 'Riff Generator - Bass (same riff, bass only)'; vol = 0.5; pan = 0.0
     fx = @((RiffFx 2), @('Guitar/Guitar.jsfx', ('0 0 0.8 0.5 0 380 0.35 0 2 1 0.5 1 ' + (& $dash 52)))) },
  @{ name = 'Solo Generator - bars 5-8 (blues in G, Retro Synth lead)'; vol = 0.3; pan = 0.15
     fx = @(@('MusicTools/SoloGenerator.jsfx', ('0 7 8 5 4 0.75 0.4 52 24 0 0 7 0.4 100 1 1 0 7 ' + (& $dash 40))), @('Synth/RetroSynth.jsfx', ('36 ' + (& $dash 70)))) },
  @{ name = 'Chords + Chord / Tab / Notes Viewer'; vol = 0.4; pan = 0.3; notes = $chordNotes
     fx = @(@('MusicTools/ChordTabViewer.jsfx', ('0 0 0 1 ' + (& $dash 40))), @('Piano/Piano.jsfx', ('0 0.25 0.6 0.4 2 ' + (& $dash 59)))) }
)
$lenSec = $BARS * 4 * 60 / $BPM
$sb = New-Object Text.StringBuilder
[void]$sb.Append("<REAPER_PROJECT 0.1 `"7.78/win64`" 0`n  TEMPO $BPM 4 4`n  LOOP 1`n")
$k = 0
foreach ($t in $tracks) {
  $k++; $i = 0
  [void]$sb.Append("  <TRACK`n    NAME `"$($t.name)`"`n    VOLPAN $($t.vol) $($t.pan) -1 -1 1`n    NCHAN 2`n    <FXCHAIN`n")
  if ($ShowFx) { [void]$sb.Append("      SHOW 1`n      LASTSEL 0`n") }
  foreach ($e in $t.fx) {
    [void]$sb.Append("      <JS `"$($e[0])`" `"`"`n        $($e[1])`n      >`n")
    [void]$sb.Append("      FXID {7A1B2C3D-0000-4000-8000-0000000C$k$('{0:00}' -f $i)0}`n      WAK 0 0`n"); $i++
  }
  [void]$sb.Append("    >`n")
  if ($t.notes) {
    [void]$sb.Append("    <ITEM`n      POSITION 0`n      LENGTH $lenSec`n      LOOP 0`n      NAME `"Chords`"`n      <SOURCE MIDI`n        HASDATA 1 $PPQ QN`n$(MidiSource $t.notes)`n      >`n    >`n")
  }
  [void]$sb.Append("  >`n")
}
[void]$sb.Append(">`n")
New-Item -ItemType Directory -Force (Split-Path $Out) | Out-Null
[IO.File]::WriteAllText($Out, $sb.ToString().Replace("`r", ''), (New-Object Text.UTF8Encoding($false)))
"wrote $Out  ($k tracks, $lenSec s)"
