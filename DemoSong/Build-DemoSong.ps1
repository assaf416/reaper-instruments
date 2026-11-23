# Build-DemoSong.ps1
# Writes DemoSong.rpp: a 24-bar song (A minor, 100 BPM, Am - F - C - G) that plays EVERY instrument of this repository
# together, for testing. Edit the arrangement below and run the script again.
#
#   powershell -ExecutionPolicy Bypass -File .\Build-DemoSong.ps1
#
# Tracks (JSFX paths are relative to REAPER's Effects folder; run Install-All.ps1 first):
#   1 Drums       Drums/Drums.jsfx                      Captain's Kit
#   2 Bass        Guitar sampler (low notes) -> BassRig/Bass Station S2
#   3 Guitar      Guitar/Guitar.jsfx  -> GuitarRig/Guitar Station S2
#   4 Organ       Organ/OrganSingle.jsfx                preset 3 "Gospel"
#   5 Piano       Piano/Piano.jsfx                      Matt's Fender Rhodes
#   6 Mellotron   Mellotron/Mellotron.jsfx              flute + violins + strings
#   7 Synth arp   Synth/RetroSynth.jsfx                 preset 27 "Pluck Arp"
#   8 Synth lead  Synth/RetroSynth.jsfx                 preset 11 "Moore Lead"
#
# Sections (bar numbers start at 1):  Intro 1-4 | Verse 5-12 | Chorus 13-20 | Outro 21-24

param(
  [string]$Out = (Join-Path $PSScriptRoot 'DemoSong.rpp')
)

$PPQ = 960; $BAR = 3840; $Q = 960; $E8 = 480; $S16 = 240
$BPM = 100; $BARS = 24
$secPerBar = 4 * 60 / $BPM

# ---------------------------------------------------------------- the song ----
# one chord per bar, repeating every 4 bars: Am F C G
$prog = @(
  @{ name='Am'; bass=33; piano=@(57,60,64); organ=@(57,60,64); gtr=@(45,52,57); pad=@(60,64,69); mel=@(76,72,69,72) },
  @{ name='F';  bass=29; piano=@(53,57,60); organ=@(53,57,60); gtr=@(41,48,53); pad=@(60,65,69); mel=@(77,76,72,69) },
  @{ name='C';  bass=36; piano=@(55,60,64); organ=@(55,60,64); gtr=@(48,55,60); pad=@(60,64,67); mel=@(76,79,76,72) },
  @{ name='G';  bass=31; piano=@(55,59,62); organ=@(55,59,62); gtr=@(43,50,55); pad=@(59,62,67); mel=@(74,79,78,74) }
)
function Section($bar) { if ($bar -lt 4) { 'intro' } elseif ($bar -lt 12) { 'verse' } elseif ($bar -lt 20) { 'chorus' } else { 'outro' } }
function Human($t) { (($t * 7) % 9) - 4 }      # deterministic +-4 velocity wobble

# per-track event lists: absolute tick, note, velocity, length
$trk = @{}; foreach ($n in 'drums','bass','gtr','organ','piano','mello','arp','lead') { $trk[$n] = New-Object System.Collections.Generic.List[object] }
function Note($track, $t, $n, $v, $len) {
  $v = [int][math]::Max(1, [math]::Min(127, $v + (Human $t)))
  $trk[$track].Add([pscustomobject]@{ t = [int]$t; n = [int]$n; v = $v; len = [int]$len })
}

for ($b = 0; $b -lt $BARS; $b++) {
  $o = $b * $BAR; $c = $prog[$b % 4]; $sec = Section $b
  $isFirstOfSection = ($b -eq 0 -or $b -eq 4 -or $b -eq 12 -or $b -eq 20)

  # ---- drums (Captain's Kit, GM notes: 36 kick, 38 snare, 42 closed hat, 46 open hat, 49 crash, 41/43/45/47 toms) ----
  if ($sec -eq 'verse' -or $sec -eq 'chorus') {
    $loud = ($sec -eq 'chorus')
    for ($i = 0; $i -lt 8; $i++) { Note 'drums' ($o + $i * $E8) 42 ($(if ($i % 2 -eq 0) { if ($loud) { 95 } else { 78 } } else { if ($loud) { 62 } else { 48 } })) 120 }
    Note 'drums' $o 36 ($(if ($loud) { 112 } else { 100 })) 120
    Note 'drums' ($o + 1920) 36 ($(if ($loud) { 108 } else { 96 })) 120
    Note 'drums' ($o + 2400) 36 ($(if ($loud) { 100 } else { 84 })) 120
    Note 'drums' ($o + 960) 38 ($(if ($loud) { 118 } else { 104 })) 120
    Note 'drums' ($o + 2880) 38 ($(if ($loud) { 122 } else { 108 })) 120
    Note 'drums' ($o + 2160) 38 36 120                      # ghost note (lowest snare layer)
    if ($loud -and ($b % 2 -eq 1)) { Note 'drums' ($o + 3360) 46 90 120 }   # open hat on the last 8th of every 2nd bar
  }
  if ($b -eq 11) {                                          # fill into the chorus: snare roll, soft -> loud
    $k = 0; foreach ($t in 2880, 3120, 3360, 3600) { Note 'drums' ($o + $t) 38 (60 + 18 * $k) 120; $k++ }
  }
  if ($b -eq 19) {                                          # fill into the outro: toms, high to low
    $k = 0; foreach ($n in 47, 45, 43, 41) { Note 'drums' ($o + 2880 + $k * $S16 * 1) $n (70 + 14 * $k) 120; $k++ }
    Note 'drums' ($o + 3600) 38 120 120
  }
  if ($isFirstOfSection -and ($sec -eq 'chorus' -or $sec -eq 'outro')) { Note 'drums' $o 49 120 120; Note 'drums' $o 36 115 120 }   # crash
  if ($sec -eq 'outro' -and $b -lt 23) {                    # outro: light groove, fading
    $fade = 100 - 18 * ($b - 20)
    for ($i = 0; $i -lt 4; $i++) { Note 'drums' ($o + $i * $Q) 42 ($fade - 25) 120 }
    Note 'drums' ($o + 1920) 36 $fade 120; if ($b -eq 20) { Note 'drums' ($o + 960) 38 ($fade) 120; Note 'drums' ($o + 2880) 38 $fade 120 }
  }
  if ($b -eq 23) { Note 'drums' $o 49 118 120; Note 'drums' $o 36 120 120 }

  # ---- bass (low notes of the Guitar sampler through the bass rig) ----
  switch ($sec) {
    'verse'  { $pat = 0,0,12,0, 0,0,12,7; for ($i = 0; $i -lt 8; $i++) { Note 'bass' ($o + $i * $E8) ($c.bass + $pat[$i]) ($(if ($i % 2 -eq 0) { 100 } else { 84 })) 400 } }
    'chorus' { $pat = 0,0,12,0, 0,12,0,7; for ($i = 0; $i -lt 8; $i++) { Note 'bass' ($o + $i * $E8) ($c.bass + $pat[$i]) ($(if ($i % 2 -eq 0) { 110 } else { 92 })) 420 } }
    'outro'  { if ($b -lt 23) { Note 'bass' $o $c.bass 100 1800; Note 'bass' ($o + 1920) $c.bass 90 1800 } else { Note 'bass' $o $c.bass 110 3700 } }
  }

  # ---- guitar (power chords through the guitar rig) ----
  switch ($sec) {
    'verse'  { for ($i = 0; $i -lt 8; $i++) { foreach ($n in $c.gtr[0], $c.gtr[1]) { Note 'gtr' ($o + $i * $E8) $n 82 260 } } }          # palm-muted 8ths
    'chorus' { for ($i = 0; $i -lt 4; $i++) { foreach ($n in $c.gtr) { Note 'gtr' ($o + $i * $Q) $n 108 880 } } }                           # open chords on every beat
    'outro'  { if ($b -eq 23) { foreach ($n in $c.gtr) { Note 'gtr' $o $n 118 3700 } } elseif ($b -eq 20) { foreach ($n in $c.gtr) { Note 'gtr' $o $n 100 3700 } } }
  }

  # ---- organ (preset 3 Gospel): whole-bar chords, fuller in the chorus ----
  $ov = switch ($sec) { 'intro' { 72 } 'verse' { 66 } 'chorus' { 88 } default { 80 } }
  foreach ($n in $c.organ) { Note 'organ' $o $n $ov ($BAR - 120) }
  if ($sec -eq 'chorus') { Note 'organ' $o ($c.organ[0] - 12) 80 ($BAR - 120) }
  if ($b -eq 23) { foreach ($n in $c.organ) { $trk['organ'].RemoveAll({ param($e) $e.t -eq $o -and $e.n -eq $n }) | Out-Null; Note 'organ' $o $n 90 3800 } }

  # ---- piano (Fender Rhodes): intro arpeggio / verse backbeat / chorus 8th comping / outro chord ----
  switch ($sec) {
    'intro'  { $arp = 0,1,2,1, 0,1,2,1; for ($i = 0; $i -lt 8; $i++) { Note 'piano' ($o + $i * $E8) $c.piano[$arp[$i]] ($(if ($i -eq 0) { 82 } else { 62 })) 450 } }
    'verse'  { foreach ($t in 960, 2880) { foreach ($n in $c.piano) { Note 'piano' ($o + $t) $n 84 700 } } }
    'chorus' { for ($i = 0; $i -lt 8; $i++) { foreach ($n in $c.piano) { Note 'piano' ($o + $i * $E8) $n ($(if ($i % 2 -eq 0) { 98 } else { 74 })) 400 } } }
    'outro'  { if ($b -eq 20 -or $b -eq 23) { foreach ($n in $c.piano) { Note 'piano' $o $n 90 3700 } } }
  }

  # ---- mellotron (flute + violins + strings): pad everywhere, melody in the chorus (and the end of the intro) ----
  if ($sec -ne 'outro' -or $b -eq 20 -or $b -eq 23) {
    $pv = switch ($sec) { 'intro' { 64 } 'verse' { 52 } 'chorus' { 70 } default { 66 } }
    foreach ($n in $c.pad) { Note 'mello' $o $n $pv ($BAR - 200) }
  }
  if ($sec -eq 'chorus' -or $b -eq 2 -or $b -eq 3) {
    for ($i = 0; $i -lt 4; $i++) { Note 'mello' ($o + $i * $Q) $c.mel[$i] 92 880 }
  }

  # ---- synth arp (Retro Synth, preset 27 "Pluck Arp"): 16th-note arpeggio through the verse and chorus ----
  if ($sec -eq 'verse' -or $sec -eq 'chorus') {
    $av = if ($sec -eq 'chorus') { 88 } else { 66 }
    $order = 0,1,2,1
    for ($i = 0; $i -lt 16; $i++) { Note 'arp' ($o + $i * $S16) ($c.pad[$order[$i % 4]] + 12) ($av + $(if ($i % 4 -eq 0) { 14 } else { 0 })) 200 }
  }

  # ---- synth lead (Retro Synth, preset 11 "Moore Lead"): doubles the melody an octave up in the second half of the chorus, final note in the outro ----
  if ($b -ge 16 -and $b -lt 20) {
    for ($i = 0; $i -lt 4; $i++) { Note 'lead' ($o + $i * $Q) ($c.mel[$i] + 12) 100 880 }
  }
  if ($b -eq 23) { Note 'lead' $o ($c.pad[0] + 12) 105 3700 }
}

# ------------------------------------------------------------------ writer ----
function MidiSource($events) {
  $e = New-Object System.Collections.Generic.List[object]
  foreach ($x in $events) { $e.Add([pscustomobject]@{ t = $x.t; s = 0x90; n = $x.n; v = $x.v }); $e.Add([pscustomobject]@{ t = $x.t + $x.len; s = 0x80; n = $x.n; v = 0 }) }
  $sorted = $e | Sort-Object t, @{ e = { if ($_.s -eq 0x80) { 0 } else { 1 } } }, n
  $prev = 0; $lines = New-Object System.Collections.Generic.List[string]
  foreach ($x in $sorted) { $lines.Add(('        E {0} {1:x2} {2:x2} {3:x2}' -f ($x.t - $prev), $x.s, $x.n, $x.v)); $prev = $x.t }
  $lines -join "`n"
}
$dashes = ((1..100 | ForEach-Object { '-' }) -join ' ')
function JS($path, $vals, $guid) { "      <JS `"$path`" `"`"`n        $vals`n      >`n      FXID {7A1B2C3D-0000-4000-8000-0000000000$guid}`n      WAK 0 0" }
$len = $BARS * $secPerBar + 3     # a few seconds of tail
function Track($name, $vol, $pan, $color, $fx, $events) {
  @"
  <TRACK
    NAME "$name"
    PEAKCOL $color
    VOLPAN $vol $pan -1 -1 1
    NCHAN 2
    <FXCHAIN
$fx
    >
    <ITEM
      POSITION 0
      LENGTH $len
      NAME "$name"
      <SOURCE MIDI
        HASDATA 1 $PPQ QN
$(MidiSource $events)
      >
    >
  >
"@
}
function Col($r, $g, $b) { 16777216 + $r + 256 * $g + 65536 * $b }

$guitarSampler = '0 0 0.8 0.5 0 380 0.35 0 2 1 0.5 1' + (' -' * 52)          # Strat, no chorus, no delay (the rigs do the tone)
$guitarFx      = '0 0.35 0.8 0.5 0.22 380 0.35 1 2 1 0.5 1' + (' -' * 52)      # Strat, light chorus, tempo-synced 1/8 ping-pong delay
$mello         = '12 7 15 0.9 0.6 0.5 0 -30 30 0.2 0.3 1' + (' -' * 52)       # flute + M300A violins + string section
$piano         = '2 0.25 0.6 0.4 1' + (' -' * 59)                               # Fender Rhodes, output 100 %
$organ         = (((1..40 | ForEach-Object { '-' }) -join ' ') + ' 3 ' + ((1..70 | ForEach-Object { '-' }) -join ' '))   # program 3: Gospel
$synthArp      = '27' + (' -' * 70)                                              # Retro Synth preset 27: Pluck Arp
$synthLead     = '11' + (' -' * 70)                                              # Retro Synth preset 11: Moore Lead
$drums         ='0 0.2 0.5 0.5 1 1 1 1 1 1 1 1 0 0 15 -20 20 0 0 0 0 0 0 0 0 0' + (' -' * 38)

$tracks = @(
  # fader values (linear): the first mix peaked at +3.5 dB on the master, so everything was pulled down ~6 dB
  (Track 'Drums (Captain''s Kit)'       0.50  0.0 (Col 200 80 60)  (JS 'Drums/Drums.jsfx' $drums '01') $trk['drums']),
  (Track 'Bass (Guitar sampler + Bass Rig)' 0.42 0.0 (Col 70 110 200) ((JS 'Guitar/Guitar.jsfx' $guitarSampler '02') + "`n" + (JS 'BassRig/Bass Station S2 (Tukan)' $dashes '03')) $trk['bass']),
  (Track 'Guitar (Guitar sampler + Guitar Rig)' 0.34 -0.35 (Col 230 150 50) ((JS 'Guitar/Guitar.jsfx' $guitarFx '04') + "`n" + (JS 'GuitarRig/Guitar Station S2 (Tukan)' $dashes '05')) $trk['gtr']),
  (Track 'Organ (Single Manual)'        0.34  0.25 (Col 120 90 160) (JS 'Organ/OrganSingle.jsfx' $organ '06') $trk['organ']),
  (Track 'Piano (Fender Rhodes)'        0.30  0.35 (Col 90 160 110) (JS 'Piano/Piano.jsfx' $piano '07') $trk['piano']),
  (Track 'Mellotron (3 tapes)'          0.34 -0.30 (Col 160 160 90) (JS 'Mellotron/Mellotron.jsfx' $mello '08') $trk['mello']),
  (Track 'Synth arp (Retro Synth - Pluck Arp)'  0.28  0.40 (Col 200 90 160) (JS 'Synth/RetroSynth.jsfx' $synthArp '09') $trk['arp']),
  (Track 'Synth lead (Retro Synth - Moore Lead)' 0.26 -0.10 (Col 90 200 200) (JS 'Synth/RetroSynth.jsfx' $synthLead '10') $trk['lead'])
)

$markers = @(@(1,0,'Intro'), @(2,(4 * $secPerBar),'Verse'), @(3,(12 * $secPerBar),'Chorus'), @(4,(20 * $secPerBar),'Outro')) | ForEach-Object {
  "  MARKER {0} {1} `"{2}`" 0 0 1 R {{7A1B2C3D-0000-4000-8000-00000000F{0}00}} 0" -f $_[0], ([string]::Format([Globalization.CultureInfo]::InvariantCulture, '{0:0.###}', $_[1])), $_[2]
}
$project = "<REAPER_PROJECT 0.1 `"7.78/win64`" 0`n  TEMPO $BPM 4 4`n  LOOP 0`n" + ($markers -join "`n") + "`n" + ($tracks -join "`n") + "`n>`n"
[IO.File]::WriteAllText($Out, $project.Replace("`r", ''), (New-Object Text.UTF8Encoding($false)))

foreach ($k in $trk.Keys | Sort-Object) { '{0,-6} {1,4} notes' -f $k, $trk[$k].Count }
"Wrote $Out  ($BARS bars, $([math]::Round($BARS * $secPerBar, 1)) s at $BPM BPM, $($tracks.Count) tracks)"
