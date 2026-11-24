# Patch-Rig.ps1 - adds hardware-controller support to a local copy of a Tukan "Station S2" rig (Guitar or Bass).
# Called by Install-GuitarRig.ps1 / Install-BassRig.ps1 after the plugin is copied to <REAPER>\Effects\<Rig>\. It only edits that local copy
# (the plugin is not redistributed with this repository). Safe to run again: it does nothing when the patch is already there.
#
#   Controls (see Controllers\README.md):  fader 4 = choose the effect,  knobs 1-4 = its four parameters (the effect is switched on),
#   bank < / bank > and the main encoder = previous / next rig preset.
param([Parameter(Mandatory)][string]$File, [ValidateSet('guitar','bass')][string]$Kind = 'guitar')
if (-not (Test-Path $File)) { throw "not found: $File" }
$raw = [IO.File]::ReadAllText($File)
if ($raw -match 'RI-CONTROLLER-PATCH') { Write-Host "already patched: $File"; return }
$nl = if ($raw -match "`r`n") { "`r`n" } else { "`n" }

# effects: name, enable slider (0 = none), parameters as slider:min:max (up to 4, knob 1..4)
if ($Kind -eq 'guitar') {
  $fx = @(
    @('Amp',     0,  '2:0:10','5:0:10','6:0:10','7:0:10'),
    @('Dist',    34, '36:0:10','37:0:10','39:-18:18','3:0:10'),
    @('Chorus',  17, '19:0:10','21:0:10'),
    @('Flanger', 22, '24:0.001:2','25:0:10','26:0:10','56:0:360'),
    @('Phaser',  27, '29:0:10','32:0:10','33:0:10','31:0:10'),
    @('Tremolo', 40, '42:0:20','43:0:10','44:0:10','45:0:10'),
    @('Delay',   50, '52:1:1000','53:0:10','54:0:10'),
    @('Reverb',  0,  '14:0:10'))
  # presets: amp, cab, pregain, dist level, bass, mid, treble, then switch settings (slider=value)
  $presets = @(
    @(1,1,2,1,5,5,6, '34=0','17=0','50=0'),
    @(1,1,2,1,5,5,6, '34=0','17=1','50=0'),
    @(2,2,5,4,5,6,5, '34=0','17=0','50=0'),
    @(2,3,6,6,5,5,6, '34=1','17=0','50=0'),
    @(3,3,7,7,4,6,7, '34=1','17=0','50=1'),
    @(4,4,8,8,6,4,7, '34=1','17=0','50=0'),
    @(1,2,3,2,6,6,4, '34=0','17=0','50=0'),
    @(1,1,3,1,5,4,6, '34=0','17=1','50=1'))
} else {
  $fx = @(
    @('Amp',     0,  '2:0:10','5:0:10','6:0:10','7:0:10'),
    @('Dist',    34, '36:0:10','37:0:10','39:-18:18','3:0:10'),
    @('Chorus',  17, '19:0:10','21:0:10'),
    @('Flanger', 22, '24:0.001:2','25:0:10','26:0:10','56:0:360'),
    @('Phaser',  27, '29:0:10','32:0:10','33:0:10','31:0:10'),
    @('DI mix',  40, '44:0:10','45:0:10','42:20:1000'),
    @('Filter',  50, '52:1:10','53:0.2:10','54:-18:18'),
    @('Compress',0,  '3:0:10','14:0:10','13:-24:24'))
  $presets = @(
    @(1,1,3,3,5,5,5, '34=0','17=0','50=0'),
    @(1,2,4,4,6,4,5, '34=0','17=0','50=0'),
    @(2,2,5,3,6,5,6, '34=1','17=0','50=0'),
    @(2,3,6,5,5,6,7, '34=1','17=0','50=0'),
    @(3,3,4,2,7,3,4, '34=0','17=0','50=1'),
    @(3,1,6,6,6,5,7, '34=1','17=1','50=0'))
}
function New-SliderSet($n, $v) { "slider$n = $v; sliderchange(2^$($n - 1));" }

# the plugin's own factory presets (RPL next to it): each is a text list of slider values
$tp = @()
$rpl = "$File.RPL"
if (Test-Path $rpl) {
  foreach ($m in [regex]::Matches([IO.File]::ReadAllText($rpl), '<PRESET `([^`]*)`\s+([A-Za-z0-9+/=\s]+?)\s*>')) {
    $txt = [Text.Encoding]::ASCII.GetString([Convert]::FromBase64String(($m.Groups[2].Value -replace '\s', '')))
    $vals = New-Object System.Collections.Generic.List[string]
    foreach ($tok in ($txt -split '\s+')) { if ($tok -match '^-?[0-9.]+(e[-+]?[0-9]+)?$') { $vals.Add($tok) } else { break } }
    if ($vals.Count -ge 10) { $tp += ,@($m.Groups[1].Value, ($vals -join ' ')) }
  }
}
$nT = $tp.Count
$sb = New-Object Text.StringBuilder
[void]$sb.AppendLine('// RI-CONTROLLER-PATCH (Reaper Instruments): hardware controller support')
[void]$sb.AppendLine("ri_nfx = $($fx.Count); ri_npre = $($nT + $presets.Count);")
[void]$sb.AppendLine('while (midirecv(ri_o, ri_a, ri_b, ri_c)) (')
[void]$sb.AppendLine('  ri_t = rc_decode(ri_a, ri_b, ri_c);')
[void]$sb.AppendLine('  (ri_a & 240) == 192 ? ( ri_prog = min(ri_b, ri_npre - 1); ri_apply(ri_prog); ) :')
# fader 4 = effect selector
$sel = "  ri_t == 1 && rc_idx == 3 ? ( ri_sel = min(ri_nfx - 1, floor(rc_val * ri_nfx)); "
for ($e = 0; $e -lt $fx.Count; $e++) { if ($fx[$e][1] -gt 0) { $sel += "ri_sel == $e ? ( $(New-SliderSet $fx[$e][1] 1) ); " } }
[void]$sb.AppendLine($sel + ') :')
[void]$sb.AppendLine('  ri_t == 2 && rc_idx < 4 ? (')
for ($e = 0; $e -lt $fx.Count; $e++) {
  for ($k = 0; $k -lt 4; $k++) {
    if ($fx[$e].Count -gt (2 + $k)) {
      $p = $fx[$e][2 + $k].Split(':')
      [void]$sb.AppendLine("    ri_sel == $e && rc_idx == $k ? ( $(New-SliderSet $p[0] "$($p[1]) + rc_val * ($($p[2]) - ($($p[1])))") ) :")
    }
  }
}
[void]$sb.AppendLine('    0;')
[void]$sb.AppendLine('  ) : (ri_t == 4 || ri_t == 5 || ri_t == 6) ? (')
[void]$sb.AppendLine('    ri_prog = (ri_prog + rc_idx + ri_npre) % ri_npre; ri_apply(ri_prog);')
[void]$sb.AppendLine('  );')
[void]$sb.AppendLine(');')
$block = ($sb.ToString() -replace "`r?`n", $nl)

# 1) import after the last existing import line, 2) rc_load() right after @init, 3) the MIDI code right after @block
$imp = [regex]::Matches($raw, '(?m)^import .*$') | Select-Object -Last 1
if (-not $imp) { throw 'no import line found - unexpected plugin layout' }
$raw = $raw.Insert($imp.Index + $imp.Length, "$($nl)import RIControllers.jsfx-inc")
$ini = New-Object Text.StringBuilder
[void]$ini.AppendLine('rc_load(); ri_sel = 0; ri_prog = 0;')
[void]$ini.AppendLine('function ri_flt() local(c, n, v, neg, sc) (')
[void]$ini.AppendLine('  n = strlen(ri_str); while (ri_pp < n && ((c = str_getchar(ri_str, ri_pp)) < 48 || c > 57) && c != 45 && c != 46) ( ri_pp += 1; );')
[void]$ini.AppendLine('  neg = 0; ri_pp < n && str_getchar(ri_str, ri_pp) == 45 ? ( neg = 1; ri_pp += 1; );')
[void]$ini.AppendLine('  v = 0; while (ri_pp < n && (c = str_getchar(ri_str, ri_pp)) >= 48 && c <= 57) ( v = v * 10 + c - 48; ri_pp += 1; );')
[void]$ini.AppendLine('  ri_pp < n && str_getchar(ri_str, ri_pp) == 46 ? ( ri_pp += 1; sc = 0.1; while (ri_pp < n && (c = str_getchar(ri_str, ri_pp)) >= 48 && c <= 57) ( v += (c - 48) * sc; sc *= 0.1; ri_pp += 1; ); );')
[void]$ini.AppendLine('  neg ? -v : v;')
[void]$ini.AppendLine(');')
[void]$ini.AppendLine('function ri_load(s) local(i) ( ri_str = s; ri_pp = 0; i = 1; loop(64, slider(i) = ri_flt(); sliderchange(2 ^ (i - 1)); i += 1; ); );')
for ($i = 0; $i -lt $nT; $i++) { [void]$ini.AppendLine("ri_s$i = `"$($tp[$i][1])`";") }
[void]$ini.AppendLine('function ri_apply(p) (')
for ($i = 0; $i -lt $nT; $i++) { [void]$ini.AppendLine("  p == $i ? ri_load(ri_s$i) :") }
for ($i = 0; $i -lt $presets.Count; $i++) {
  $p = $presets[$i]
  $s = "  p == $($nT + $i) ? ( $(New-SliderSet 9 $p[0]) $(New-SliderSet 10 $p[1]) $(New-SliderSet 2 $p[2]) $(New-SliderSet 5 $p[4]) $(New-SliderSet 6 $p[5]) $(New-SliderSet 7 $p[6]) "
  $s += (New-SliderSet 3 $p[3]) + ' '
  foreach ($sw in $p[7..($p.Count - 1)]) { $a = $sw.Split('='); $s += (New-SliderSet $a[0] $a[1]) + ' ' }
  [void]$ini.AppendLine($s + ') :')
}
[void]$ini.AppendLine('  0;')
[void]$ini.AppendLine(');')
$initcode = ($ini.ToString() -replace "`r?`n", $nl)
$raw = [regex]::Replace($raw, '(?m)^@init[ \t]*\r?$', { param($m) "@init$nl$initcode" }, 1)
$raw = [regex]::Replace($raw, '(?m)^@block[ \t]*\r?$', { param($m) "@block$nl$block" }, 1)
[IO.File]::WriteAllText($File, $raw, (New-Object Text.UTF8Encoding($false)))
Write-Host "patched ($Kind): $File"
