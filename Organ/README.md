# Organ

A tonewheel (Hammond-style) organ with a rotary speaker, in two versions:

| File | What it is |
|------|-----------|
| [`original/LordOfTheRinks.jsfx`](original/LordOfTheRinks.jsfx) | **Lord of the Rinks** by chmaha (a port of setBfree), included **unmodified**: upper and lower manuals, pedals, the 128 setBfree programs |
| [`OrganSingle.jsfx`](OrganSingle.jsfx) | **Single-manual edition** with your own preset bank - see below |

Both are pure synthesis (no samples). Install them with `Install-Organ.ps1`, then **FX -> Add** and search for
*Tonewheel Organ - Single Manual* or *Lord of the Rinks*. Demo project: `projects\Organ_Demo.rpp`.

## Single-manual edition

* **One keyboard.** The UI shows only the upper manual (C2-C7). Clicking a key plays it; keys light up for incoming MIDI.
  Notes on **every MIDI channel** play the upper manual (and every channel shares one controller map), so any keyboard just works.
* **One drawbar group** (UPPER MANUAL, 9 drawbars) instead of upper / pedal / lower.
* **Preset buttons.** 20 presets as buttons next to the drawbars; click one to load it (the LCD at the top still has
  the program menu and the arrows). Each preset sets the drawbars, percussion (on / soft / fast / 2nd harmonic), the
  vibrato/chorus scanner, Leslie (slow / stop / fast), overdrive and reverb.
* Everything else is unchanged: percussion, vibrato/chorus, overdrive, reverb, Leslie (with the DETAILS page),
  SETTINGS page (tone generator, tuning, transpose), STORE (your own programs 111-128, saved with the project),
  MIDI learn (right-click a control), MIDI program change (program change *n* selects preset *n+1*).

### The preset bank

| # | Preset | Drawbars | Notes |
|---|--------|----------|-------|
| 1 | Jimmy Smith | 888000000 | percussion (3rd, fast), C3, Leslie fast |
| 2 | Green Onions | 888800000 | percussion 2nd, V2, Leslie slow |
| 3 | Gospel | 888000008 | C3, Leslie slow |
| 4 | Procol Harum | 808800000 | V1, Leslie slow |
| 5 | Deep Purple | 888800000 | overdrive, Leslie fast |
| 6 | Emerson Growl | 888888000 | overdrive, Leslie fast |
| 7 | Full Organ | 888888888 | V3 |
| 8 | Ballad Flutes | 008400000 | soft percussion, C2, lots of reverb |
| 9 | Church Plenum | 648755322 | no vibrato, Leslie stopped, big reverb |
| 10 | Jazz 88 | 880000000 | soft/fast percussion 2nd, C3 |
| 11 | Funk Stab | 008808000 | percussion fast, Leslie fast |
| 12 | Reggae Skank | 008600000 | soft/fast percussion 2nd, Leslie stopped |
| 13 | Warm Pad | 606500000 | C1, reverb |
| 14 | Reedy Lead | 008686840 | V3, Leslie fast |
| 15 | Whistler | 008000008 | percussion fast, C3 |
| 16 | Low Down | 808000000 | Leslie stopped |
| 17 | Clean Drawbars | 888000000 | no effects - a neutral starting point |
| 18 | Rotary Dream | 808080000 | C1, big reverb |
| 19 | Smokey | 868500000 | V2, overdrive |
| 20 | Wall of Sound | 888888888 | overdrive, Leslie fast |

**Make it yours:** open `OrganSingle.jsfx` and search for `CUSTOM PRESET BANK`. Every preset is two lines
(`mkpreset(...)` and `mem_set_values(...)`) with a comment explaining the fields. Edit, add (up to 110) or reorder them; the
first 20 get on-screen buttons (`NPRESET`). Re-run `Install-Organ.ps1` after editing.

## Credits

See [CREDITS.md](CREDITS.md).
