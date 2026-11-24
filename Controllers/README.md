# Hardware controllers

All instruments read the same controller map, so a keyboard works the same everywhere. Built for the **M-Audio Oxygen Pro Mini**
(4 faders, 8 knobs, 8 pads, mod wheel, BANK < / >, main encoder); other keyboards work by editing the map.

| Control | What it does |
|---|---|
| Mod wheel (CC1) | Organ: Leslie slow (down) / fast (up) |
| Faders 1-3 | Mellotron: level of tape 1 / 2 / 3. Fader 4: Mellotron master. Piano, Guitar, Drums, GeneralMIDI: fader 1 = volume |
| Fader 4 | Guitar Rig / Bass Rig: **choose the effect** (Amp, Dist, Chorus, Flanger, Phaser, Tremolo or DI mix, Delay or Filter, Reverb or Compressor) |
| Knobs 1-4 | Guitar Rig / Bass Rig: the four parameters of the chosen effect (it is switched on). Other instruments: reverb / mix / tone (see each plugin) |
| Knobs 5-8 | Guitar sampler: chorus mix, delay mix, delay time, feedback |
| BANK < / BANK > and the main encoder | previous / next preset in **every** instrument (Organ 36 presets, Synth 50, Mellotron tape sets, Piano / Guitar / Drum kits, GeneralMIDI programs, rig presets) |
| Pads | send on MIDI channel 10 (drums). Instruments other than Drums ignore channel 10 |

Controller messages pass from the Guitar sampler on to the rig that follows it in the chain.

## Setup
1. `Install-Controllers.ps1` (done by `..\Install-All.ps1`) installs `RIControllers.jsfx-inc` and `Data\Controllers\controllers.txt`.
2. The CC numbers in `controllers.txt` are placeholders until you run **`Learn-Controller.ps1`** in a terminal: it asks you to move each
   control once and writes the real numbers (close REAPER first if the device is busy). Or edit the first line of the file by hand.
3. Rigs: `GuitarRig\Install-GuitarRig.ps1` / `BassRig\Install-BassRig.ps1` run `Patch-Rig.ps1`, which adds the controller code to the local copy of
   the Tukan plugin (never to the repository).

`manuals\` has the manufacturers' PDFs (Oxygen Pro Mini, MPS-850, nanoKONTROL2) and their text versions; it is not committed.
The Oxygen Pro Mini's CC numbers are set by its Preset Editor, which is why they are learned rather than fixed. nanoKONTROL2 factory CCs:
sliders 0-7, knobs 16-23.

## Keyboard split with Tilr's MIDI tools
`Install-TilrMidiTools.ps1` downloads **MIDI Keyvel Filter** and **GFX MIDI Filter** by tilr (tiagolr/tilr_jsfx, from its ReaPack index) into `Effects\Tilr\`
(third-party, not part of this repository). `projects\Oxygen_Split_Demo.rpp` (made by `Build-OxygenSplitDemo.ps1`) uses the Keyvel filter as a key-range
splitter in front of each instrument: bass on the low keys (Guitar sampler + Bass Rig), organ in the middle, piano on top, and the Drums on the pads
(channel 10). All four tracks are armed; set each track's record input to the Oxygen (Drums: channel 10 only).
Tilr's *Notes to CC* and *Vel to CC* are not used.
