# Learn-Controller.ps1 - find out which MIDI messages your keyboard really sends and write Data\Controllers\controllers.txt.
# Run it in a terminal (REAPER should NOT have the keyboard's MIDI input open exclusively; close REAPER if the device is "in use"):
#   powershell -ExecutionPolicy Bypass -File .\Learn-Controller.ps1            (default device: the first one with "Oxygen" in its name)
#   powershell -ExecutionPolicy Bypass -File .\Learn-Controller.ps1 -Device 2  (pick a device number from the list)
# It asks you to move each control once. Press Enter to skip a control (the default stays), type q + Enter to stop early.
param(
  [int]$Device = -1,
  [string]$Name = 'Oxygen',
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
Add-Type @'
using System; using System.Collections.Concurrent; using System.Runtime.InteropServices; using System.Text;
public class MidiIn {
  delegate void Proc(IntPtr h, uint msg, IntPtr inst, IntPtr p1, IntPtr p2);
  [DllImport("winmm.dll")] static extern uint midiInGetNumDevs();
  [DllImport("winmm.dll", CharSet=CharSet.Auto)] static extern uint midiInGetDevCaps(UIntPtr id, ref CAPS c, uint size);
  [DllImport("winmm.dll")] static extern uint midiInOpen(out IntPtr h, uint id, Proc cb, IntPtr inst, uint flags);
  [DllImport("winmm.dll")] static extern uint midiInStart(IntPtr h);
  [DllImport("winmm.dll")] static extern uint midiInClose(IntPtr h);
  [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)] struct CAPS { public ushort mid, pid; public uint ver; [MarshalAs(UnmanagedType.ByValTStr, SizeConst=32)] public string name; public uint sup; }
  public static ConcurrentQueue<uint> Q = new ConcurrentQueue<uint>();
  static Proc keep; static IntPtr hnd;
  public static string[] List() { var l = new string[midiInGetNumDevs()]; for (uint i = 0; i < l.Length; i++) { var c = new CAPS(); midiInGetDevCaps((UIntPtr)i, ref c, (uint)Marshal.SizeOf(c)); l[i] = c.name; } return l; }
  public static uint Open(uint id) { keep = (h, m, i, p1, p2) => { if (m == 0x3C3) Q.Enqueue((uint)p1.ToInt64()); }; uint r = midiInOpen(out hnd, id, keep, IntPtr.Zero, 0x30000); if (r == 0) midiInStart(hnd); return r; }
  public static void Close() { midiInClose(hnd); }
}
'@
$devs = [MidiIn]::List()
if (-not $devs.Count) { throw 'No MIDI input devices found.' }
"MIDI inputs:"; for ($i = 0; $i -lt $devs.Count; $i++) { "  [$i] $($devs[$i])" }
if ($Device -lt 0) { for ($i = 0; $i -lt $devs.Count; $i++) { if ($devs[$i] -like "*$Name*") { $Device = $i; break } } }
if ($Device -lt 0) { throw "No device matching '$Name'. Re-run with -Device <number>." }
$r = [MidiIn]::Open([uint32]$Device); if ($r -ne 0) { throw "Could not open '$($devs[$Device])' (error $r) - is REAPER using it? Close REAPER and try again." }
"Using [$Device] $($devs[$Device])"; ""

function Flush { $x = 0u; while ([MidiIn]::Q.TryDequeue([ref]$x)) {} }
# wait for the next message of a kind: 'cc' (returns @(cc, value)), 'note' (returns @(note, channel1based))
function WaitFor([string]$kind, [int]$ms = 15000) {
  Flush; $sw = [Diagnostics.Stopwatch]::StartNew()
  while ($sw.ElapsedMilliseconds -lt $ms) {
    if ([Console]::KeyAvailable) { $k = [Console]::ReadKey($true); if ($k.Key -eq 'Q') { return 'quit' } return $null }
    $m = 0u
    if ([MidiIn]::Q.TryDequeue([ref]$m)) {
      $st = $m -band 0xF0; $d1 = ($m -shr 8) -band 0x7F; $d2 = ($m -shr 16) -band 0x7F; $ch = ($m -band 0x0F) + 1
      if ($kind -eq 'cc' -and $st -eq 0xB0) { return @($d1, $d2, $ch) }
      if ($kind -eq 'note' -and $st -eq 0x90 -and $d2 -gt 0) { return @($d1, $ch) }
    } else { Start-Sleep -Milliseconds 10 }
  }
  return $null
}
$def = @{ mod = 1; f = @(70,71,72,73); k = @(21,22,23,24,25,26,27,28); bp = 106; bn = 107; enc = 108; emode = 0; pad = 10 }
$quit = $false
function Ask([string]$prompt) {
  if ($script:quit) { return $null }
  Write-Host "$prompt  (Enter = skip, q = stop) ... " -NoNewline
  $r = WaitFor 'cc'
  if ($r -is [string]) { $script:quit = $true; Write-Host 'stopped'; return $null }
  if ($null -eq $r) { Write-Host 'skipped'; return $null }
  Write-Host "CC $($r[0]) (value $($r[1]), channel $($r[2]))"; Start-Sleep -Milliseconds 400; return $r
}
$r = Ask 'Move the MOD wheel'; if ($r) { $def.mod = $r[0] }
for ($i = 0; $i -lt 4; $i++) { $r = Ask "Move FADER $($i + 1)"; if ($r) { $def.f[$i] = $r[0] } }
for ($i = 0; $i -lt 8; $i++) { $r = Ask "Turn KNOB $($i + 1)"; if ($r) { $def.k[$i] = $r[0] } }
$r = Ask 'Press BANK <'; if ($r) { $def.bp = $r[0] }
$r = Ask 'Press BANK >'; if ($r) { $def.bn = $r[0] }
Write-Host 'Turn the main ENCODER slowly to the right, several clicks ... ' -NoNewline
Flush; $vals = @(); $enc = -1; $sw = [Diagnostics.Stopwatch]::StartNew()
while (-not $quit -and $sw.ElapsedMilliseconds -lt 12000 -and $vals.Count -lt 4) {
  $r = WaitFor 'cc' 4000; if ($r -is [string]) { $quit = $true; break }; if ($null -eq $r) { break }
  if ($enc -lt 0) { $enc = $r[0] }; if ($r[0] -eq $enc) { $vals += $r[1] }
}
if ($vals.Count -gt 0) {
  $def.enc = $enc
  if (($vals | Where-Object { $_ -ge 1 -and $_ -le 3 }).Count -eq $vals.Count) { $def.emode = 2 }          # 1,1,1 = two's complement, right = small numbers
  elseif (($vals | Where-Object { $_ -ge 65 -and $_ -le 70 }).Count -eq $vals.Count) { $def.emode = 1 }    # 65,65 = offset 64, right = above 64
  else { $def.emode = 0 }
  Write-Host "CC $enc, values $($vals -join ',') -> mode $($def.emode)"
} else { Write-Host 'skipped' }
if (-not $quit) {
  Write-Host 'Hit a PAD (for the drum channel) ... ' -NoNewline
  $r = WaitFor 'note'
  if ($r -is [array]) { $def.pad = $r[1]; Write-Host "note $($r[0]) on channel $($r[1])" } else { Write-Host 'skipped' }
}
[MidiIn]::Close()
$line = '{0} {1} {2} {3} {4} {5} {6}' -f $def.mod, ($def.f -join ' '), ($def.k -join ' '), $def.bp, $def.bn, $def.enc, "$($def.emode) $($def.pad)"
$dir = Join-Path $ReaperResources 'Data\Controllers'; New-Item -ItemType Directory -Force $dir | Out-Null
$txt = $line + "`n# mod fader1-4 knob1-8 bankPrev bankNext encoder encoderMode padChannel   (written by Learn-Controller.ps1 for $($devs[$Device]))`n"
[IO.File]::WriteAllText((Join-Path $dir 'controllers.txt'), $txt, (New-Object Text.UTF8Encoding($false)))
[IO.File]::WriteAllText((Join-Path $PSScriptRoot 'controllers.txt'), $txt, (New-Object Text.UTF8Encoding($false)))
""; "Saved: $(Join-Path $dir 'controllers.txt')"; $line
"Reload the instruments (or re-open the project) so they read the new map."
