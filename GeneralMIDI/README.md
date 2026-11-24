# General MIDI

A General MIDI sound module for REAPER built from the **Fluid R3 GM2** SoundFont: 128 GM programs, 61 variation presets
(banks 8, 9 and 16) and 31 drum kits, all played from WAV samples stored in this folder.

* `GeneralMIDI.jsfx` - the instrument (JSFX, graphic UI only).
* `samples\` - all 1,418 samples of the SoundFont as mono 16-bit WAV (about 141 MB), `index.txt` lists them.
* `maps\` - one zone map per preset (`p_BANK_PROG.txt` and `p_BANK_PROG_files.txt`) and `presets.txt` (preset names).
* `Build-GeneralMidi-Assets.ps1` - re-extracts `samples\` and `maps\` from an SF2 (`-Sf2 path`), 1 second.
* `Install-GeneralMidi.ps1` - copies the plugin into REAPER and links this folder as `Data\GeneralMIDI` (a junction, no copying).
* `Build-GeneralMidi-Demo.ps1` - rewrites `projects\GeneralMIDI_Demo.rpp` (piano, strings, bass and a drum kit).

## Use

Run `Install-GeneralMidi.ps1` (or `..\Install-All.ps1`), then FX -> Add -> "General MIDI" on a track with MIDI.

* **MELODIC tab**: pick a family (16 GM families), a program (8 per family) and, when the program has them, a variation bank.
* **DRUM KITS tab**: pick one of the 31 kits (Standard, Room, Power, Electronic, TR-808, Jazz, Brush, Orchestra, ...).
* Volume, reverb mix and reverb size bars (Ctrl+click resets). The keyboard shows the notes that sound.
* MIDI in: notes + velocity, pitch bend (+-2), CC64 sustain, CC7 volume, Bank Select (CC0) + Program Change, CC123 all notes off.
  Send Program Change 0..127 to switch sounds from the track, or automate the bank / program.

What the engine does per sample zone: key and velocity ranges, root key and tuning, loop points (sustain loops follow the key),
volume envelope (delay / attack / hold / decay / sustain / release), pan, attenuation, low-pass cutoff, reverb send and
exclusive classes (closed hi-hat cuts the open one). Presets load on demand (the biggest drum kit reads about 11 MB).

## Limits

Modulation envelopes, LFOs, filter resonance and SoundFont modulators are not implemented, so some pads and effects sound simpler
than in a full SF2 player. Samples are mono (stereo pairs are separate zones, as in the SoundFont). 64 voices.

Neither the SoundFont (141 MB) nor the extracted WAV files are in the Git repository (the `.gitignore` excludes them, as for the other instruments). After cloning, put the SF2 in `..\fluid-gm2\` and run `Build-GeneralMidi-Assets.ps1` to regenerate `samples\`.
See [CREDITS.md](CREDITS.md).
