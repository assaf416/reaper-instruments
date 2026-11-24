# Retro Synth

A 16-voice analog-style polysynth (pure synthesis, no samples) with a bank of **34 presets for 70s and 80s sounds**:
pads, leads, basses, brass, keys and effects.

## Sound engine

* **Oscillators**: two, each saw / pulse (with PWM) / triangle / sine, band-limited (PolyBLEP); octave per oscillator,
  detune, plus a **sub oscillator** and **noise**; **1-4 unison** voices with spread.
* **Filter**: 4-pole resonant ladder low-pass with envelope amount, key tracking and LFO.
* **Envelopes**: two ADSRs (amp and filter), times from 1 ms to 8 s.
* **LFO** to pitch (vibrato, also on the mod wheel), filter and pulse width.
* **Play**: glide, mono / legato mode, pitch bend (+-2), mod wheel (CC1), sustain pedal (CC64), program change selects a preset.
* **Effects**: stereo chorus, ping-pong delay, reverb, drive.

## The UI

Round knobs with coloured value arcs in dark panels (OSCILLATORS, FILTER, AMP ENVELOPE, FILTER ENVELOPE, LFO, PLAY, CHORUS, DELAY, REVERB, DRIVE), in the style of the JamSynth and Synthy McSynthface panels by chmaha.
Click the preset display to browse (PADS / LEADS / BASS / KEYS and FX) or use its arrows. Drag a knob up or down (Shift = fine), use the mouse wheel, or double-click / **Ctrl+click** to reset it to the Init value. The wave boxes and MONO switch toggle on click.

## Presets

| Group | Presets |
|-------|---------|
| Pads | Genesis Strings, Banks Pad, Floyd Wash, Wright Pad, Duran Pad, Marillion Pad, Jarre Sweep, Oxygene Pad, Warm Prophet, Choir Pad, Glass Pad |
| Leads | Moore Lead, Genesis Solo, Marillion Lead, Jarre Lead, Prog Mono Lead, Duran Lead, Brass Lead |
| Bass | Duran Bass, Moog Bass, Sub Bass, Sequence Bass, Rubber Bass, Floyd Bass |
| Keys & FX | Jupiter Brass, Poly Brass, String Machine, Pluck Arp, Bell Keys, Pulse Clav, Pulse Pluck, VCS3 Sweep, Wind FX, Init Saw |

The names say which artist / era the sound is **inspired by** (string machines and Prophet-style pads for the Genesis and
Marillion keyboard textures, VCS3 sweeps and slow washes for Pink Floyd, bright Jupiter-style pads and a pulse bass for
Duran Duran, a sustained overdriven mono lead for Gary Moore, Oxygene-style sweeps and sequence bass for Jean-Michel
Jarre). They are **original patch designs** that aim at the character of those sounds. They are not copies of any
artist's actual patches, and they will not sound identical to the records.

## Make your own presets

Open `RetroSynth.jsfx` and search for `preset data`. A preset is one `mem_set_values(PR + n*36, ...)` line of 36 numbers
(oscillators, filter / envelopes / LFO, play / effects; the order is documented in the comment above the table), and a
name in the `pname[n] = "..."` list. To add one, raise `NP` (and the Preset slider range and the browser layout if needed).
Re-run `Install-Synth.ps1` after editing.

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-Synth.ps1
```

then **FX -> Add -> Retro Synth**. Demo project: `projects\Synth_Demo.rpp` (pad, bass, lead and arp on four tracks, each
with a different preset).
