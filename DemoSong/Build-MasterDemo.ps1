# Build-MasterDemo.ps1
# Regenerates the two "master demo" projects in the repository root with valid REAPER syntax:
#   MASTER_DEMO_All_Instruments.rpp      every instrument of this repository, plugins only
#   MASTER_DEMO_All_Instruments_v2.rpp   the same, plus the Guitar Rig (Guitar Station S2) and Bass Rig (Bass Station S2) on the guitar and bass tracks
# Eight tracks play a short phrase together, repeated for 4 bars at 120 BPM. Run Install-All.ps1 first.
# (The earlier versions used invented project syntax - JS entries split into folder and file name, NOTES lines - so REAPER could not
#  load the plugins or the notes. This script writes real <JS "Folder/File.jsfx" ""> entries and real MIDI events.)
#
#   powershell -ExecutionPolicy Bypass -File .\Build-MasterDemo.ps1

param(
  [string]$OutDir = (Split-Path $PSScriptRoot -Parent)
)
$PPQ = 960; $BPM = 120; $REPEATS = 4; $PHRASE_BEATS = 4
$dash = { param($n) ((1..$n | ForEach-Object { '-' }) -join ' ') }

# phrase notes as (pitch, velocity, start beat, length in beats), taken from the original demo
$tracks = @(
  @{ name='1. Mellotron - Lush String Pad';                  vol=0.50; pan=-0.2; js=,@('Mellotron/Mellotron.jsfx', '12 7 15 0.9 0.6 0.5 0 -30 30 0.2 0.3 1 ' + (& $dash 52));
     notes=@(@(60,100,0,1), @(64,100,0.5,1), @(67,100,1,1), @(72,100,1.5,1)) },
  @{ name='2. Organ - Owner of a Lonely Heart (organ preset 21)'; vol=0.45; pan=0.2; js=,@('Organ/OrganSingle.jsfx', ((& $dash 40) + ' 21 ' + (& $dash 70)));
     notes=@(@(48,100,0,2), @(52,100,2,2)) },
  @{ name='3. Piano - Warm Acoustic (Midnight Upright)';     vol=0.70; pan=0.3;  js=,@('Piano/Piano.jsfx', '0 0.25 0.6 0.4 2 ' + (& $dash 59));
     notes=@(@(60,100,0,1), @(64,100,1,1), @(67,100,2,1), @(72,100,3,1)) },
  @{ name='4. Synth - Shine Lead (synth preset 36)';         vol=0.30; pan=-0.1; js=,@('Synth/RetroSynth.jsfx', '36 ' + (& $dash 70));
     notes=@(@(72,100,0,2), @(76,100,2,2)) },
  @{ name='5. Guitar - Warm Lead';                           vol=0.35; pan=-0.35; js=,@('Guitar/Guitar.jsfx', '0 0.35 0.8 0.5 0.3 380 0.4 1 2 1 0.5 1 ' + (& $dash 52)); rig=@('GuitarRig/Guitar Station S2 (Tukan)');
     notes=@(@(60,100,0,1), @(64,100,1,1), @(67,100,2,1), @(72,100,3,1)) },
  @{ name='6. Bass - Deep Foundation (Guitar sampler, low note)'; vol=0.45; pan=0.0; js=,@('Guitar/Guitar.jsfx', '0 0 0.8 0.5 0 380 0.35 0 2 1 0.5 1 ' + (& $dash 52)); rig=@('BassRig/Bass Station S2 (Tukan)');
     notes=@(@(36,100,0,4)) },
  @{ name='7. Synth Pad - Lush Choir (synth preset 9)';      vol=0.30; pan=0.35; js=,@('Synth/RetroSynth.jsfx', '9 ' + (& $dash 70));
     notes=@(@(48,100,0,4), @(52,100,0,4)) },
  @{ name='8. Lead Synth - Overdriven Moore Lead (synth preset 11)'; vol=0.28; pan=0.0; js=,@('Synth/RetroSynth.jsfx', '11 ' + (& $dash 70));
     notes=@(@(64,100,0,2), @(69,100,2,2)) }
)

function MidiSource($notes) {
  $ev = New-Object System.Collections.Generic.List[object]
  for ($r = 0; $r -lt $REPEATS; $r++) {
    foreach ($n in $notes) {
      $t = [int](($r * $PHRASE_BEATS + $n[2]) * $PPQ); $len = [int]($n[3] * $PPQ * 0.95)
      $ev.Add([pscustomobject]@{ t = $t; s = 0x90; n = $n[0]; v = $n[1] })
      $ev.Add([pscustomobject]@{ t = $t + $len; s = 0x80; n = $n[0]; v = 0 })
    }
  }
  $sorted = $ev | Sort-Object t, @{ e = { if ($_.s -eq 0x80) { 0 } else { 1 } } }, n
  $prev = 0; $lines = New-Object System.Collections.Generic.List[string]
  foreach ($x in $sorted) { $lines.Add(('        E {0} {1:x2} {2:x2} {3:x2}' -f ($x.t - $prev), $x.s, $x.n, $x.v)); $prev = $x.t }
  $lines -join "`n"
}
function Fx($entries, $guidBase) {
  $out = New-Object System.Collections.Generic.List[string]; $i = 0
  foreach ($e in $entries) {
    $out.Add("      <JS `"$($e[0])`" `"`"`n        $($e[1])`n      >`n      FXID {7A1B2C3D-0000-4000-8000-$($guidBase)$('{0:00}' -f $i)}`n      WAK 0 0"); $i++
  }
  $out -join "`n"
}

$lenSec = $REPEATS * $PHRASE_BEATS * 60 / $BPM
foreach ($variant in @(@{ file = 'MASTER_DEMO_All_Instruments.rpp'; rigs = $false; tag = '0A' }, @{ file = 'MASTER_DEMO_All_Instruments_v2.rpp'; rigs = $true; tag = '0B' })) {
  $sb = New-Object Text.StringBuilder
  [void]$sb.Append("<REAPER_PROJECT 0.1 `"7.78/win64`" 0`n  TEMPO $BPM 4 4`n  LOOP 1`n")
  $k = 0
  foreach ($t in $tracks) {
    $k++
    $entries = @($t.js)
    if ($variant.rigs -and $t.rig) { $entries += ,@($t.rig[0], ((& $dash 100))) }
    $guid = '000000' + $variant.tag + ('{0:00}' -f $k)          # 10 hex digits, unique per variant and track (a 2-digit index is added per plugin)
    [void]$sb.Append(@"
  <TRACK
    NAME "$($t.name)"
    VOLPAN $($t.vol) $($t.pan) -1 -1 1
    NCHAN 2
    <FXCHAIN
$(Fx $entries $guid)
    >
    <ITEM
      POSITION 0
      LENGTH $lenSec
      LOOP 1
      NAME "$($t.name)"
      <SOURCE MIDI
        HASDATA 1 $PPQ QN
$(MidiSource $t.notes)
      >
    >
  >

"@)
  }
  [void]$sb.Append(">`n")
  $path = Join-Path $OutDir $variant.file
  [IO.File]::WriteAllText($path, $sb.ToString().Replace("`r", ''), (New-Object Text.UTF8Encoding($false)))
  $txt = $sb.ToString()
  '{0,-38} {1} tracks, {2} plugin instances, {3} note-ons, {4} s' -f $variant.file, ([regex]::Matches($txt, '(?m)^  <TRACK')).Count, ([regex]::Matches($txt, '<JS "')).Count, ([regex]::Matches($txt, '(?m)^\s+E \d+ 90 ')).Count, $lenSec
}
