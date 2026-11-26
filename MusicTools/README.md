# Music Tools

Three musical helpers for REAPER, written as **pure JSFX** (EEL2): nothing to install except the files in this folder - no ReaScript, no Lua,
no extensions, no SWS. They work on a clean REAPER install. All three have the dark knob-style UI of the other instruments in this
repository (coloured section headers, round knobs, amber LCD with arrows).

| Tool | File | What it does |
|------|------|--------------|
| **Chord / Tab / Notes Viewer** | `ChordTabViewer.jsfx` | Shows what the MIDI on its track plays: chord name, note names, piano keys, a guitar fretboard with the chord shape (or every position of the notes), the chord as tab, a tab strip of the last notes, and a **chord chart per bar** that fills while the project plays |
| **Solo Generator** | `SoloGenerator.jsfx` | Composes a lead line for the **bars you pick** (first bar + number of bars) over the chords of the song; piano roll + tab in its own window; plays in sync with the transport, only inside those bars |
| **Riff Generator** | `RiffGenerator.jsfx` | Type chord bars like `/Am,Dm6/E7/Am/`, pick style, bars, key and mode, press **GENERATE**: a **guitar riff and a bass line** (MIDI), piano roll + guitar / bass tab, plays in sync with the transport. 14 presets named after famous riffs / styles, including the Hendrix-style riff in G at 80 BPM |

`MusicLib.jsfx-inc` holds the shared code (chord names, scales, chord parser, tab fitting, MIDI player, UI widgets). Screenshots are in
[`screenshots/`](screenshots).

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-MusicTools.ps1
```

(or `Install-All.ps1` in the repository root). The files go to `<REAPER>\Effects\MusicTools\`. In REAPER: **FX -> Add**, search *Chord / Tab*,
*Solo Generator* or *Riff Generator*. Demo project: [`projects/MusicTools_Demo.rpp`](projects/MusicTools_Demo.rpp) (regenerate it with
`Build-MusicToolsDemo.ps1`; it uses the Guitar, Retro Synth and Piano instruments, so run `Install-All.ps1` first).

## The chord syntax

`/Am,Dm6/E7/Am/` - bars are separated by `/`, chords inside a bar by `,` (a bar with two chords gives each half a bar, three chords a third...).
Roots `A`-`G` with `#` or `b`; qualities: *(major)* `m` `7` `m7` `maj7` `6` `m6` `dim` `dim7` `m7b5` `aug` `sus4` `sus2` `5` `9` `7#9` `m9` `add9`
`7sus4` `maj9` (`13` / `11` are played as `9`). If the string is empty, the Riff Generator builds a progression from the key and mode.

## Chord / Tab / Notes Viewer - how does it get the notes?

A JSFX can only see the MIDI that reaches **its own track** (it cannot read other tracks or the project file), so there are three ways to use it:

1. **Insert it on the track that holds the MIDI item** (before the instrument). It follows that track while the project plays; MIDI is passed through unchanged.
2. Make a **"Chord View" track** and add **MIDI sends** from the tracks you want to analyse (one send per track, MIDI only). The viewer then shows the combined harmony.
3. Play your controller into it live.

While the project plays, every beat is recorded into a chart (REC button, saved with the project). Play the song once and the 16-bar chord chart
page is complete; the arrows page through long songs, **click a bar** to inspect that chord on the fretboard (LIVE returns to the live view).
The chart assumes the time signature of the moment (`ts_num`); songs with time-signature changes get a chart that is only right in the main signature.
A JSFX gets MIDI only when it plays - it cannot look ahead in the song, which is why the chart fills "as you play" instead of instantly.

## Solo Generator

* **First bar / bars** pick where in the song the solo lives; **key / scale** (major, minor, dorian, phrygian, lydian, mixolydian, both pentatonics, blues, harmonic minor)
  and **FOLLOW** either *key scale* (key scale plus the chord tones) or *chord scales* (mixolydian over dominants, dorian over m7, ... changes with the chord).
* **Styles**: Blues, Rock Lead, Pentatonic Runs, Neo-Classical, Jazz, Country, Funk, Ballad - they change the rhythm, step size, leaps, chromatic approach notes,
  slide-in grace notes, note length and phrasing. Phrases are built as A A' B A'' (a motif, its answer, a contrast, the motif with a new ending), each heading for a
  target note; the last note resolves to the chord root.
* **Density, space (rests), humanize, velocity, low note, range, seed**; **NEW IDEA** picks a new seed, the same seed always gives the same solo.
* **Chords come from**: `TYPED` - the chord chart of the song typed as `/Am/Am/Dm/Dm/E7/E7/Am/E7/` (bar 1 first; a shorter chart repeats), or `LEARNED` - the plugin
  listens to MIDI chords that reach its track while the project plays (use MIDI sends from the chord tracks; THRU passes them on) and builds the chart itself.
* **SYNC** plays the solo in the project bars you chose; **AUDITION** plays it in a loop with the project tempo without the transport.
* Output is plain MIDI, channel 1 by default.

## Riff Generator

* **Presets** (arrows or click the LCD): Hendrix Style - G Funk-Blues Stabs (80 BPM), Hendrix Style - E7#9 Chord Stabs, Slow 12-Bar Blues Shuffle in G, Classic Rock Power Riff in Em,
  Metal Chug in E, Funk Chank in A Dorian, Reggae Skank in G, Surf / Spy Riff in E Harmonic Minor, Dotted-Eighth Arpeggios in D, Blues Boogie in A, Hendrix Style - Soul Ballad in C,
  Dark Minor Riff Am-G-F-E, Hendrix Style - Slow Minor Blues in Am, and *Custom*. They are **original riffs in the style of** those players / songs (rhythm pattern,
  chord voicing, scale and feel), not transcriptions of any recording. A preset sets style, key, mode, bars, tempo, density, variation and the chord bars.
* **Styles** (8): Hendrix Funk-Blues (chord stabs with pentatonic fills), Blues Shuffle, Rock Power Riff, Metal Chug, Funk Chank, Reggae Skank, Surf / Spy, Pop Arpeggio -
  each one has a main bar and a turnaround for the last bar, a matching bass pattern (root, octave, fifth, third, passing and approach notes into the next chord) and a swing amount.
* **Bars (1-16)** loops or truncates the typed chord bars; **density**, **variation** (ghost notes), **humanize**, **guitar / bass level**, **seed** (NEW IDEA).
* The riff loops from the **start bar** you choose. **SYNC** follows the transport at the project tempo; **AUDITION** plays it with the plugin's own **tempo** knob (80 BPM for the
  Hendrix preset) - REAPER's project tempo cannot be set from a JSFX, so set the project to the preset tempo yourself.
* The window shows a piano roll (guitar amber, bass green, chord names above) and a **guitar tab** (standard tuning, chord stabs fitted to fret shapes) and a **bass tab**; 4 bars per page.

## Which track setup works with the existing instruments

Both generators output **plain MIDI** and no audio, so put the instrument after them in the same chain. The Riff Generator sends the guitar on MIDI channel 1 and the bass on channel 2
(the *Guitar MIDI channel* slider moves both).

* **One instance per instrument (what the demo does):** track 1 `Riff Generator (SEND: GUITAR ONLY)` -> `Guitar/Guitar.jsfx`; track 2 `Riff Generator (SEND: BASS ONLY)` -> `Guitar/Guitar.jsfx`
  set to the bass sound (same preset and seed = the same riff). The Guitar Rig / Bass Rig FX chains from `GuitarRig/` and `BassRig/` can follow the sampler.
* **One track, two channels:** `Riff Generator (GUITAR + BASS)` -> `GeneralMIDI` (a multi-channel instrument: guitar program on channel 1, bass program on channel 2).
* **Synth leads:** `Solo Generator` -> `Synth/RetroSynth.jsfx` (the demo uses preset 36, a lead) or `Guitar/Guitar.jsfx` for a guitar solo.
* To get the notes as a normal MIDI item: arm the track and record its MIDI output (right-click the record-arm button -> *Record: output (MIDI)*) while the project plays.
  *(Not tested here.)*

## What was tested

Tested in REAPER 7.78 (Windows 11): all three plugins compile without errors (the FX windows open with the full UI, checked on screenshots), the Hendrix-style preset in G at 80 BPM
generates and draws a four-bar riff (98 guitar notes, 33 bass notes), the playhead follows the transport, the "MIDI notes sent" counter at the bottom counts the notes that were sent
as the project plays, the Solo Generator plays inside bars 5-8 of the demo project, and the Viewer detected G7#9 / C9 / D9 chords from a MIDI item, drew the right fret shapes (for example
C9 = x32333, Dm = xx0231) and filled the chord chart while the project played. A selection of presets and styles was opened and looked at on screenshots (Hendrix G, 12-bar shuffle,
Surf / Spy, Solo: Blues, Neo-Classical, Jazz, Ballad); the Metal Chug preset was loaded without errors but its result was not inspected, and not every one of the 14 riff presets was opened.

**Not tested:** listening to the result with the Guitar / Retro Synth / GeneralMIDI instruments (the sound was not auditioned - only the MIDI events, the piano roll and the counters were checked),
the LEARNED chord source of the Solo Generator, the *Record: output (MIDI)* workflow, pitch of the generated lines on a real fretboard by a guitarist, songs with tempo or time-signature changes.
The Install script was not run against a clean REAPER; the folder is a plain copy to `Effects\MusicTools`.

## Notes for hackers

* EEL2 variable names are **case-insensitive** (a table `STY` and a variable `sty` are the same thing) - all shared tables have names that cannot collide with locals.
* `midisend` only works in `@block`; everything that should play is generated into event lists (`EV_*` arrays) and the player in `MusicLib.jsfx-inc` (`pl_range`) turns the block's beat
  range into sample-accurate note-ons / note-offs, with a note-off safety net on stop and seek.
* The chord string and the learned chart are saved with the project (`@serialize`); a new instance applies the preset or example named by its sliders.
