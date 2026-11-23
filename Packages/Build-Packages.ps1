# Build-Packages.ps1
# Builds REAPER packages (.ReaperPkg, the format added in REAPER 7.86) for the instruments in this repository.
# A .ReaperPkg is a zip with a reaper-package-info.txt plus files placed under REAPER's resource-folder directories
# (Effects, Data, FXChains, ProjectTemplates, Docs ...). Spec: https://www.reaper.fm/sdk/reaper-package-info.txt
#
#   powershell -ExecutionPolicy Bypass -File .\Build-Packages.ps1                    # everything -> dist\
#   powershell -ExecutionPolicy Bypass -File .\Build-Packages.ps1 -Only Organ,Synth  # just some
#
# Packages that carry samples are large (the samples are installed into REAPER's Data folder - no folder links needed).
# dist\ is git-ignored: the packages hold third-party samples / plugin files that must not be published.

param(
  [string[]]$Only = @(),
  [string]$Version = '1.0',
  [string]$OutDir = (Join-Path $PSScriptRoot 'dist'),
  [string]$Url = 'https://github.com/assaf416/reaper-instruments',
  [string]$Author = 'assaf416'
)
$Only = @($Only | ForEach-Object { $_ -split ',' } | Where-Object { $_.Trim() } | ForEach-Object { $_.Trim() })   # "-Only A,B" arrives as one string with -File
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
$repo = Split-Path $PSScriptRoot -Parent
New-Item -ItemType Directory -Force $OutDir | Out-Null
$allowed = 'AutomationItems','ColorThemes','Data','Docs','Effects','FXChains','KeyMaps','MouseMaps','MenuSets','OSC','presets','ProjectTemplates','Scripts','TrackTemplates','UserPlugins','reaper_www_root','Cursors','LangPack'

# ---------- helpers: a package is a list of @{ src = <file on disk>; entry = <path inside the zip> } ----------
function F($src, $entry) { @{ src = $src; entry = $entry } }
function FilesFrom($dir, $prefix, $filter = '*', [switch]$Recurse) {
  if (-not (Test-Path $dir)) { return @() }
  $base = (Get-Item $dir).FullName.TrimEnd('\')
  Get-ChildItem $dir -File -Filter $filter -Recurse:$Recurse | ForEach-Object {
    F $_.FullName ($prefix.TrimEnd('/') + '/' + ($_.FullName.Substring($base.Length + 1) -replace '\\', '/'))
  }
}
function ListedSamples($filesTxt, $root, $dataPrefix) {
  # one path per line, relative to REAPER's Data folder (e.g. Pianos/<key>/Samples/x.wav); the file lives under $root\<key>\...
  Get-Content $filesTxt | Where-Object { $_.Trim() } | ForEach-Object {
    $rel = $_.Trim()                                   # Pianos/MidnightUpright/Samples/x.wav
    $sub = $rel.Substring($rel.IndexOf('/') + 1)       # MidnightUpright/Samples/x.wav
    $src = Join-Path $root ($sub -replace '/', '\')
    if (Test-Path $src) { F $src ('Data/' + $rel) } else { Write-Warning "missing sample: $src" }
  }
}
function Demo($rpp, $templateName) { if (Test-Path $rpp) { F $rpp ("ProjectTemplates/$templateName.RPP") } }

function New-Package($key, $title, $info, $files) {
  $files = @($files | Where-Object { $_ })
  if ($files.Count -eq 0) { Write-Warning "$key : nothing to package"; return }
  foreach ($f in $files) {
    $top = ($f.entry -split '/')[0]
    if ($allowed -notcontains $top) { throw "$key : '$($f.entry)' is not in a directory REAPER packages may install into" }
  }
  $name = "Reaper Instruments - $title"
  $pkg = Join-Path $OutDir ("ReaperInstruments-$key-$Version.ReaperPkg")
  if (Test-Path $pkg) { Remove-Item $pkg -Force }
  $infoTxt = @"
NAME "$name"
AUTHOR "$Author"
VERSION "$Version"
URL "$Url"
INFO "README.txt"
"@
  $zip = [IO.Compression.ZipFile]::Open($pkg, 'Create')
  try {
    foreach ($pair in @(@('reaper-package-info.txt', $infoTxt), @('README.txt', $info))) {
      $e = $zip.CreateEntry($pair[0]); $w = New-Object IO.StreamWriter($e.Open(), (New-Object Text.UTF8Encoding($false)))
      $w.Write(($pair[1].Replace("`r", '') + "`n")); $w.Dispose()
    }
    foreach ($f in $files) { [void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $f.src, $f.entry, [IO.Compression.CompressionLevel]::Fastest) }
  } finally { $zip.Dispose() }
  '{0,-12} {1,5} files {2,8:N1} MB  {3}' -f $key, $files.Count, ((Get-Item $pkg).Length / 1MB), (Split-Path $pkg -Leaf)
}
function Want($key) { $Only.Count -eq 0 -or ($Only -contains $key) }

# ---------- the packages ----------
if (Want 'Organ') {
  New-Package 'Organ' 'Organ (Lord of the Rinks + single manual)' @"
Tonewheel organ with rotary speaker. Installs two plugins into Effects/Organ:
  OrganSingle.jsfx   single-manual edition with a 20-preset bank and one keyboard
  LordOfTheRinks.jsfx  the original plugin by chmaha (GPLv3+, a setBfree port), unmodified
In REAPER: FX -> Add -> 'Tonewheel Organ - Single Manual' (or 'Lord of the Rinks').
A demo project is available from File -> New project from template.
"@ @(
    (F "$repo\Organ\OrganSingle.jsfx" 'Effects/Organ/OrganSingle.jsfx'),
    (F "$repo\Organ\original\LordOfTheRinks.jsfx" 'Effects/Organ/LordOfTheRinks.jsfx'),
    (Demo "$repo\Organ\projects\Organ_Demo.rpp" 'Reaper Instruments - Organ demo'))
}
if (Want 'Synth') {
  New-Package 'Synth' 'Retro Synth' @"
16-voice analog-style polysynth with 34 presets inspired by 70s / 80s sounds (pure synthesis, no samples).
Installs Effects/Synth/RetroSynth.jsfx. In REAPER: FX -> Add -> 'Retro Synth'.
A demo project is available from File -> New project from template.
"@ @(
    (F "$repo\Synth\RetroSynth.jsfx" 'Effects/Synth/RetroSynth.jsfx'),
    (Demo "$repo\Synth\projects\Synth_Demo.rpp" 'Reaper Instruments - Synth demo'))
}
if (Want 'Drums') {
  $files = @(F "$repo\Drums\Drums.jsfx" 'Effects/Drums/Drums.jsfx') + @(FilesFrom "$repo\Drums\maps" 'Data/Drums' '*.txt') + @(FilesFrom "$repo\Drums\samples" 'Data/Drumkits' '*.flac') + @(Demo "$repo\Drums\projects\Drums_Demo.rpp" 'Reaper Instruments - Drums demo')
  New-Package 'Drums' 'Drums (5 kits, mixer, reverb, MIDI map)' @"
Five velocity-layered drum kits (AVL Drumkits by Glen MacArthur, CC-BY-SA 3.0, repackaged by chmaha) with a 7-channel mixer, reverb
and a MIDI note / CC map editor with Learn for e-drums. Installs Effects/Drums/Drums.jsfx, the kit maps (Data/Drums) and the five
kit files (Data/Drumkits). In REAPER: FX -> Add -> 'Drums'. Demo project: File -> New project from template.
"@ $files
}
if (Want 'Guitar') {
  $files = @(F "$repo\Guitar\Guitar.jsfx" 'Effects/Guitar/Guitar.jsfx') + @(FilesFrom "$repo\Guitar\maps" 'Data/Guitars' '*.txt')
  foreach ($k in 'Strat62','AsatClean','AsatDI') { $files += @(ListedSamples "$repo\Guitar\maps\${k}_files.txt" "$repo\Guitar\samples" 'Data') }
  $files += @(F "$repo\GuitarRig\Guitar + Rig.RfxChain" 'FXChains/Reaper Instruments - Guitar + Rig.RfxChain')
  $files += @(Demo "$repo\Guitar\projects\Guitar_Demo.rpp" 'Reaper Instruments - Guitar demo')
  New-Package 'Guitar' 'Guitar (3 electric guitars, chorus, delay)' @"
62 Reissue Stratocaster, ASAT Clean and ASAT DI from the Decent Sampler library, with a stereo chorus and a tempo-syncable ping-pong
delay. Installs Effects/Guitar/Guitar.jsfx, the sample maps and the samples (Data/Guitars). In REAPER: FX -> Add -> 'Guitar'.
The FX chain 'Guitar + Rig' needs the separate Guitar Rig package. Demo project: File -> New project from template.
"@ $files
}
if (Want 'Piano') {
  $files = @(F "$repo\Piano\Piano.jsfx" 'Effects/Piano/Piano.jsfx') + @(FilesFrom "$repo\Piano\maps" 'Data/Pianos' '*.txt')
  foreach ($k in 'MidnightUpright','KingsUpright','FenderRhodes','WurliTzer') { $files += @(ListedSamples "$repo\Piano\maps\${k}_files.txt" "$repo\Piano\samples" 'Data') }
  $files += @(Demo "$repo\Piano\projects\Piano_Demo.rpp" 'Reaper Instruments - Piano demo')
  New-Package 'Piano' 'Piano (Midnight Upright, Upright, Rhodes, WurliTzer)' @"
Four velocity-layered pianos with reverb: Midnight Upright, The King's Upright, Matt's Fender Rhodes and the WurliTzer 1.2 by Daniel Rosenholm.
Installs Effects/Piano/Piano.jsfx, the sample maps and the samples (Data/Pianos, about 900 MB). In REAPER: FX -> Add -> 'Piano'.
Demo project: File -> New project from template.
"@ $files
}
if (Want 'Mellotron') {
  $files = @(F "$repo\Mellotron\Mellotron.jsfx" 'Effects/Mellotron/Mellotron.jsfx')
  Get-ChildItem "$repo\Mellotron\samples\DecenTron" -Directory | ForEach-Object { $files += @(FilesFrom $_.FullName ('Data/DecenTron/' + $_.Name) '*.wav') }
  $files += @(Demo "$repo\Mellotron\projects\Mellotron_Sampler_Demo.rpp" 'Reaper Instruments - Mellotron demo')
  New-Package 'Mellotron' 'Mellotron (3 tapes, DecenTron)' @"
Three Mellotron tapes at once from the DecenTron library by Stefano 'garubi' Garuti (24 tape sets, 35 notes each).
Installs Effects/Mellotron/Mellotron.jsfx and the samples (Data/DecenTron, about 540 MB). In REAPER: FX -> Add -> 'Mellotron'.
Demo project: File -> New project from template.
"@ $files
}
if (Want 'GuitarRig') {
  $files = @(FilesFrom "$repo\GuitarRig\vendor" 'Effects/GuitarRig' '*' -Recurse) + @(F "$repo\GuitarRig\Guitar + Rig.RfxChain" 'FXChains/Reaper Instruments - Guitar + Rig.RfxChain') + @(Demo "$repo\GuitarRig\projects\GuitarRig_Demo.rpp" 'Reaper Instruments - Guitar Rig demo')
  New-Package 'GuitarRig' 'Guitar Rig (Guitar Station S2) - LOCAL USE ONLY' @"
Tukan Studios' Guitar Station S2 (amps, cabinets, pedals) installed into Effects/GuitarRig, plus the FX chain 'Guitar + Rig'.
LOCAL USE ONLY: Tukan Studios' repository declares no license, so do not publish or share this package.
In REAPER: FX -> Add -> 'Guitar Station S2 (Tukan)', or the FX chain 'Reaper Instruments - Guitar + Rig'.
"@ $files
}
if (Want 'BassRig') {
  $files = @(FilesFrom "$repo\BassRig\vendor" 'Effects/BassRig' '*' -Recurse) + @(F "$repo\BassRig\Bass Rig.RfxChain" 'FXChains/Reaper Instruments - Bass Rig.RfxChain') + @(Demo "$repo\BassRig\projects\BassRig_Demo.rpp" 'Reaper Instruments - Bass Rig demo')
  New-Package 'BassRig' 'Bass Rig (Bass Station S2) - LOCAL USE ONLY' @"
Tukan Studios' Bass Station S2 (bass amp, cabinets, gate, modulation) installed into Effects/BassRig, plus the FX chain 'Bass Rig'.
LOCAL USE ONLY: Tukan Studios' repository declares no license, so do not publish or share this package.
In REAPER: FX -> Add -> 'Bass Station S2 (Tukan)', or the FX chain 'Reaper Instruments - Bass Rig'.
"@ $files
}
if (Want 'DemoSong') {
  New-Package 'DemoSong' 'Demo Song (all instruments)' @"
A 24-bar song that plays every instrument of the Reaper Instruments collection together (drums, bass through the bass rig, guitar through the
guitar rig, organ, Rhodes, Mellotron). Install the instrument packages first. Open it from File -> New project from template.
"@ @((F "$repo\DemoSong\DemoSong.rpp" 'ProjectTemplates/Reaper Instruments - Demo Song.RPP'))
}

# ---------- validate what was built ----------
"--- validation"
foreach ($p in Get-ChildItem $OutDir -Filter *.ReaperPkg) {
  $z = [IO.Compression.ZipFile]::OpenRead($p.FullName)
  try {
    $names = $z.Entries | ForEach-Object { $_.FullName }
    $hasInfo = $names -contains 'reaper-package-info.txt'
    $bad = $names | Where-Object { $_ -notin 'reaper-package-info.txt','README.txt' -and ($allowed -notcontains ($_ -split '/')[0]) }
    $infoText = (New-Object IO.StreamReader(($z.GetEntry('reaper-package-info.txt')).Open())).ReadToEnd()
    '{0,-44} info:{1} entries:{2} bad-paths:{3} NAME-line:{4}' -f $p.Name, $hasInfo, $names.Count, @($bad).Count, ($infoText -match '(?m)^NAME ".+"$')
  } finally { $z.Dispose() }
}
