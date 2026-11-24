# Writes projects\GeneralMIDI_Demo.rpp: four tracks (piano, strings, bass, drum kit) playing a short Am-F-C-G loop.
$PPQ=960
function Src($notes){ $ev=@(); foreach($n in $notes){ $t=[int]($n[2]*$PPQ); $l=[int]($n[3]*$PPQ*0.95); $ev+=[pscustomobject]@{t=$t;s=0x90;n=$n[0];v=$n[1]}; $ev+=[pscustomobject]@{t=$t+$l;s=0x80;n=$n[0];v=0} }
  $p=0; ($ev | Sort-Object t,@{e={if($_.s -eq 0x80){0}else{1}}},n | ForEach-Object { $r='        E {0} {1:x2} {2:x2} {3:x2}' -f ($_.t-$p),$_.s,$_.n,$_.v; $p=$_.t; $r }) -join "`n" }
$ch=@(@(57,60,64),@(53,57,60),@(48,52,55),@(55,59,62)); $bs=@(45,41,36,43)
$pn=@();$st=@();$ba=@();$dr=@()
for($b=0;$b -lt 8;$b++){ $c=$ch[$b%4]; $beat=$b*4
  foreach($n in $c){ $st+=,@(($n+12),80,$beat,4) }
  for($i=0;$i -lt 8;$i++){ $pn+=,@(($c[$i%3]+12),(70+10*($i%2)),($beat+$i*0.5),0.5) }
  for($i=0;$i -lt 4;$i++){ $ba+=,@($bs[$b%4],100,($beat+$i),0.9) }
  for($i=0;$i -lt 8;$i++){ $dr+=,@(42,(60+20*($i%2)),($beat+$i*0.5),0.2) }
  $dr+=,@(36,110,$beat,0.2); $dr+=,@(38,110,$beat+1,0.2); $dr+=,@(36,100,$beat+2,0.2); $dr+=,@(38,110,$beat+3,0.2) }
$tr=@(
 @{n='Piano (0:0)';   v='0 0';   s=$pn; vol=0.6},
 @{n='Strings (0:48)';v='0 48';  s=$st; vol=0.5},
 @{n='Bass (0:33)';   v='0 33';  s=$ba; vol=0.6},
 @{n='Standard kit (128:0)'; v='128 0'; s=$dr; vol=0.6})
$sb=New-Object Text.StringBuilder; [void]$sb.Append("<REAPER_PROJECT 0.1 `"7.78/win64`" 0`n  TEMPO 100 4 4`n  LOOP 1`n"); $k=0
foreach($t in $tr){ $k++
 [void]$sb.Append("  <TRACK`n    NAME `"$($t.n)`"`n    VOLPAN $($t.vol) 0 -1 -1 1`n    NCHAN 2`n    <FXCHAIN`n      <JS `"GeneralMIDI/GeneralMIDI.jsfx`" `"`"`n        $($t.v) - - - $((1..60|%{'-'}) -join ' ')`n      >`n      FXID {7A1B2C3D-0000-4000-8000-0000000C0${k}00}`n      WAK 0 0`n    >`n    <ITEM`n      POSITION 0`n      LENGTH $(32*4*60/100)`n      LOOP 1`n      <SOURCE MIDI`n        HASDATA 1 $PPQ QN`n$(Src $t.s)`n      >`n    >`n  >`n") }
[void]$sb.Append(">`n")
$out=Join-Path $PSScriptRoot 'projects\GeneralMIDI_Demo.rpp'; New-Item -ItemType Directory -Force (Split-Path $out)|Out-Null
[IO.File]::WriteAllText($out,$sb.ToString().Replace("`r",''),(New-Object Text.UTF8Encoding($false))); "wrote $out"
