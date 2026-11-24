# Writes projects\Oxygen_Split_Demo.rpp: the Oxygen Pro Mini as a live rig. Four armed tracks share the keyboard:
#   Bass   keys C-1..B2 (0-47)   -> Tilr MIDI Keyvel Filter -> Guitar sampler (low) -> Bass Rig
#   Organ  keys C3..B4 (48-71)   -> filter -> Organ (single manual)
#   Piano  keys C5..G9 (72-127)  -> filter -> Piano (Rhodes)
#   Drums  pads (channel 10)     -> Drums   (the other instruments ignore channel 10)
# Needs Install-All.ps1 and Install-TilrMidiTools.ps1. Set each track's record input to your Oxygen (the Drums track: channel 10 only).
$dash = { param($n) ((1..$n | ForEach-Object { '-' }) -join ' ') }
$tracks = @(
 @{ n='Bass (keys 0-47)';    chain=@(@('Tilr/MIDI Keyvel Filter.jsfx','0 47 0 127 0'), @('Guitar/Guitar.jsfx',('0 0 0.8 0.5 0 380 0.35 0 2 1 0.5 1 ' + (& $dash 52))), @('BassRig/Bass Station S2 (Tukan)',(& $dash 100))) },
 @{ n='Organ (keys 48-71)';  chain=@(@('Tilr/MIDI Keyvel Filter.jsfx','48 71 0 127 0'), @('Organ/OrganSingle.jsfx',((& $dash 40) + ' 21 ' + (& $dash 70)))) },
 @{ n='Piano (keys 72-127)'; chain=@(@('Tilr/MIDI Keyvel Filter.jsfx','72 127 0 127 0'), @('Piano/Piano.jsfx',('2 0.25 0.6 0.4 1 ' + (& $dash 59)))) },
 @{ n='Drums (pads, channel 10)'; chain=@(,@('Drums/Drums.jsfx',(& $dash 60))) })
$sb = New-Object Text.StringBuilder; [void]$sb.Append("<REAPER_PROJECT 0.1 `"7.78/win64`" 0`n  TEMPO 100 4 4`n")
$k = 0
foreach ($t in $tracks) { $k++; $i = 0
  [void]$sb.Append("  <TRACK`n    NAME `"$($t.n)`"`n    VOLPAN 0.6 0 -1 -1 1`n    NCHAN 2`n    ISBUS 0 0`n    REC 1 0 1 0 0 0 0`n    <FXCHAIN`n")
  foreach ($e in $t.chain) { $i++; [void]$sb.Append("      <JS `"$($e[0])`" `"`"`n        $($e[1])`n      >`n      FXID {7A1B2C3D-0000-4000-8000-0000000D$k$('{0:00}' -f $i)0}`n      WAK 0 0`n") }
  [void]$sb.Append("    >`n  >`n") }
[void]$sb.Append(">`n")
$out = Join-Path $PSScriptRoot 'projects\Oxygen_Split_Demo.rpp'; New-Item -ItemType Directory -Force (Split-Path $out) | Out-Null
[IO.File]::WriteAllText($out, $sb.ToString().Replace("`r",''), (New-Object Text.UTF8Encoding($false))); "wrote $out"
