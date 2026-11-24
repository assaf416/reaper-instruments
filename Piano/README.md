# Piano

Four velocity-layered pianos with reverb. Click an instrument cell (or the display arrows) to load one; drag the round knobs to set the reverb and output level (style after the Jexed and JamSynth panels by chmaha; all drawing code is new)
(Ctrl+click resets). The keyboard at the bottom lights up with the notes you play, and a line shows which velocity layer
the last note used. The sustain pedal (CC64) works.

| Piano | Library | Layers | Notes |
|-------|---------|--------|-------|
| Midnight Upright | Midnight Upright V2 | 3 (soft / medium / hard) | acoustic upright, 51 samples |
| The King's Upright | The King's Upright | 2 | acoustic upright, 46 samples |
| Matt's Fender Rhodes | Matt's Fender Rhodes | 4 | electric piano, 100 samples (every 3rd key) |
| WurliTzer | WurliTzer 1.2 by Daniel Rosenholm (pianobook.co.uk) | up to 5 per key | electric piano ("Line" pickup signal), 138 samples, folded to mono |

Each piano plays the first 3.5-6 seconds of every note with a smooth fade (the full libraries are 330-650 MB each).

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-Piano.ps1
```

then **FX -> Add -> Piano**. Demo project: `projects\Piano_Demo.rpp`.

`Build-Piano-Assets.ps1` (maintainers) re-reads the libraries' `.dspreset` files, copies **only the samples that are used**
(plus each library's images, readme and presets) into `samples\<piano>\`, and writes `maps\<piano>_map.txt` / `_files.txt`.
Map line: `root lo hi loVel hiVel start length gainDb tuneSemis monoFold`.

## Credits

Samples belong to their authors and keep their licenses - see the readme / preset files in each `samples\<piano>\` folder
(`WurliTzer\README.txt` has the WurliTzer story and license notes).
