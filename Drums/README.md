# Drums

Five drum kits with velocity layers, a 7-channel mixer, reverb, and a MIDI map editor for electronic drum kits.

## Kits

| Kit | Based on | Pieces | Notes |
|-----|---------|--------|-------|
| Captain's Kit | AVL "Black Pearl" 4-piece | 26 (notes 36-61) | 5 velocity layers, hi-hat and cymbal chokes |
| Led Head | AVL "Red Zeppelin" 4-piece | 26 (notes 36-61) | 5 velocity layers |
| Goldibops | AVL "Blonde Bop" (sticks) | 27 (notes 35-61) | 5 velocity layers |
| Goldibops Hot Rods | AVL "Blonde Bop" (hot rods) | 27 (notes 35-61) | 5 velocity layers |
| Busk Stop | AVL "Buskman's Holiday" | 21 (notes 35-55) | hand percussion, 10 velocity layers |

## The UI

* **Kit display** at the top (arrows, or the five numbered cells at the right) - loads a kit (its FLAC is read into memory, a few seconds for the big ones).
* **MIXER tab** - 7 channel strips (Kick, Snare, Hi-Hat, Tom, Floor, Cymbals, Perc; Busk Stop has its own names)
  with round level and pan knobs, mute and level meter, a master strip, and the reverb (mix, room, damping). The look follows the chmaha Jexed and JamSynth panels; the drawing code is new.
  Ctrl+click resets a control.
* **MIDI MAP tab**
  * *Note map*: for every piece of the current kit, the MIDI note your e-kit sends to play it.
    **Learn** then hit the pad; `-` / `+` nudge the number; **E-kit GM preset** maps the General MIDI notes
    (kick 36, snare 38/40, hats 42/44/46, toms, crash, ride ...); **Default** restores the kit's own notes; **Clear** empties it.
  * *CC map*: Master Volume (default CC7), Reverb Mix (CC91), Hi-Hat Pedal (CC4, chokes ringing hi-hats). **Learn** works here too.
  * Every kit keeps its **own** note and CC map, saved with the project.
  * *MIDI monitor*: the last note / CC received and the piece it plays.

For an electronic kit (Millenium MPS-850, Roland TD series, ...): load a kit, open MIDI MAP, press **E-kit GM preset**,
then use **Learn** on any piece whose pad sends a different note.

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-Drums.ps1
```

then **FX -> Add -> Drums**. Demo project: `projects\Drums_Demo.rpp`.
`Build-Drum-Assets.ps1` re-creates `samples/`, `images/`, `licenses/` and `maps/` from REAPER's "DSP to JSFX" collection.

## Credits

See [CREDITS.md](CREDITS.md).
