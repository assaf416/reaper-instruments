# Guitar Sampler - Quick Start Guide

**Get started in 5 minutes with sample-based guitar + legendary tone presets.**

---

## 30-Second Overview

This instrument lets you:
1. **Load guitar samples** (ReaSampler plugin)
2. **Apply legendary guitar tones** (Guitar Station S2 rig)
3. **Play via MIDI keyboard** (triggered from your M-Audio Oxygen)
4. **Experiment with police sounds** (dramatic sound design)

---

## Step 1: Create a Track (1 minute)

1. Open Reaper
2. **Tracks → Insert new track** (or Cmd/Ctrl + T)
3. Name it: `Guitar - Gilmour Warm Lead`
4. Set input: **None** (not needed for samples)

---

## Step 2: Add ReaSampler (2 minutes)

1. Click **FX** button on the track
2. Add plugin: **FX → Add → ReaSampler**
3. In ReaSampler browser:
   - Navigate to: `Guitar/samples/Guitars/Clean Electric Guitar/Samples/`
   - Load: `C4.wav`
4. Set ReaSampler to **Monophonic mode** (plays one note at a time)
5. Close ReaSampler window

---

## Step 3: Add Guitar Station S2 (1 minute)

1. Click **FX** button again
2. Add plugin: **FX → Add → Guitar Station S2 (Tukan)**
3. Configure using settings from **GUITAR_SAMPLER_PRESETS.md**
   - For Gilmour: Bass 6.5, Mid 5.5, Treble 7.5, etc.

---

## Step 4: Play! (30 seconds)

1. Click the track to select it
2. Use your **M-Audio Oxygen Pro Mini** keyboard to play notes
3. Each note triggers the guitar sample
4. The Tukan rig processes it with Gilmour's warm reverb/chorus

**You're done!** 🎸

---

## Next: Try Different Presets

### Quick Preset List

| Preset | Sound | Settings Link |
|--------|-------|---|
| Gilmour | Warm, sustaining lead | GUITAR_SAMPLER_PRESETS.md #1 |
| Beatles | Jangly, bright clean | GUITAR_SAMPLER_PRESETS.md #2 |
| Hendrix | Heavy fuzz & sustain | GUITAR_SAMPLER_PRESETS.md #3 |
| Deep Purple | Thick overdrive | GUITAR_SAMPLER_PRESETS.md #4 |
| Iron Maiden | Bright metal crunch | GUITAR_SAMPLER_PRESETS.md #5 |
| Nirvana | Grunge wall of sound | GUITAR_SAMPLER_PRESETS.md #6 |
| Queen | Lush orchestral | GUITAR_SAMPLER_PRESETS.md #7 |
| Dire Straits | Clean strat warmth | GUITAR_SAMPLER_PRESETS.md #8 |
| Metallica/Megadeth | High-gain metal | GUITAR_SAMPLER_PRESETS.md #9 |
| Rage Against Machine | Heavy experimental | GUITAR_SAMPLER_PRESETS.md #10 |

---

## Recommended Sample Starting Points

### For Each Style

| Style | Sample Type | Location | Notes |
|-------|------------|----------|-------|
| Gilmour | Clean Electric | `Clean Electric Guitar/C4.wav` | Bright, cuts through mix |
| Beatles | 12 String | `12 String Acoustic/C4.wav` | Jangly shimmer |
| Hendrix | Clean Electric | `Clean Electric Guitar/E4.wav` | High notes for sustain |
| Deep Purple | Classic Electric | `RJS Classic Electric/C3.wav` | Warm, full |
| Iron Maiden | Clean Electric | `NLMDAGuitar/E4.wav` | High notes, articulate |
| Nirvana | Clean Electric | `Clean Electric Guitar/C2.wav` | Low for power |
| Queen | 12 String | `12 String Acoustic/C3.wav` | Warm, shimmering |
| Dire Straits | Clean Electric | `Clean Electric Guitar/C4.wav` | Mid-range warmth |
| Metallica | Clean Electric | `Clean Electric Guitar/E4.wav` | High for harmonics |
| RATM | Clean Electric | `Clean Electric Guitar/C2.wav` | Full range |

---

## Police Sounds Quick Setup

### Add Police Siren Track

1. Create new track: `Police Siren - Drama`
2. Add **ReaSampler**
   - Load: `samples/Police/police_classic.wav` (or similar)
3. Add **Guitar Station S2**
4. Use settings from **POLICE_SOUNDS.md → Classic Police Drama** preset
5. Play via MIDI keyboard for dramatic effect

---

## Creating a Multi-Instrument Song

### Example: 60-Second Demo Song

```
Part 1 (0-15s): Foundation
  Track 1: Synth Bass (RetroSynth - Cars preset)
  MIDI: C2 for 15 seconds (steady)

Part 2 (15-30s): Rhythm
  Track 2: Guitar - Nirvana tone (Grunge)
  MIDI: Power chord pattern (C2-G2, repeated)

Part 3 (30-45s): Harmony
  Track 3: Guitar - Queen tone (Lush pad)
  MIDI: C3-E3-G3 chord (sustained)

Part 4 (45-60s): Drama
  Track 4: Police Siren (Classic Drama preset)
  MIDI: Trigger siren bursts rhythmically
  Result: Cinematic climax
```

---

## Keyboard Control Tips

### M-Audio Oxygen Pro Mini

**Playing Guitar Samples:**
- Use **keyboard keys** to trigger different notes
- C4 is a good starting note
- Higher notes = higher pitch
- Lower notes = lower pitch

**Expression Control:**
- Use **mod wheel** (left side) for vibrato/effects
- Use **velocity** (how hard you press) for dynamics
- Use **sustain pedal** (if connected) for extended notes

**Switching Tracks:**
- Click track in Reaper to select
- Keyboard input goes to selected track
- Mute/solo tracks for mixing

---

## Workflow Tips

### Layering Sounds
1. Create multiple tracks (each with different guitar preset)
2. Play same MIDI notes on each track
3. Each plays through different rig
4. Mix volumes for final balance

### Recording Performance
1. Click **Record** button on track
2. Play keyboard (MIDI captured to track)
3. Click **Stop** to finish
4. Playback: Press **Spacebar**
5. Adjust volumes and effects

### Saving Your Work
1. **File → Save As**
2. Name: `My Guitar Song - All Presets.rpp`
3. Location: Save in project folder for easy access

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| **No sound when playing keyboard** | 1) Check track is selected (highlighted) 2) Check ReaSampler volume isn't at -∞ 3) Check Reaper output isn't muted |
| **Sample sounds weird** | 1) Check you loaded correct sample 2) Try different sample (C4, D4, etc.) 3) Adjust ReaSampler pitch if needed |
| **Can't hear effects** | 1) Check Guitar Station S2 is added 2) Check preset settings loaded correctly 3) Increase reverb/delay mix % |
| **Police siren too loud** | 1) Lower ReaSampler volume 2) Reduce pre-gain on Guitar Station 2) Use master track volume to adjust |
| **Too much latency** | 1) Reduce buffer size in Reaper preferences 2) Use fewer effects 3) Freeze tracks with heavy processing |

---

## Next Steps

1. **Explore Presets** - Try all 10 guitar tones with different samples
2. **Layer Sounds** - Create tracks with multiple guitar tones
3. **Add Police Sounds** - Experiment with sirens + guitar combinations
4. **Create Full Song** - Layer guitar + synth + other instruments
5. **Record Performance** - Play your own parts via keyboard

---

## File Locations

| What | Where |
|------|-------|
| **Guitar Samples** | `/GuitarRig/Guitar/samples/Guitars/` |
| **Police Sounds** | `/GuitarSampler/samples/Police/` |
| **Preset Settings** | `GUITAR_SAMPLER_PRESETS.md` |
| **Police Details** | `POLICE_SOUNDS.md` |
| **Full Documentation** | `README.md` |

---

## Share Your Creation

Once you've created something cool:
1. **Export as audio**: File → Render to file
2. **Share online** (SoundCloud, YouTube, etc.)
3. **Tag**: #GuitarSampler #ReaperInstruments
4. Have fun experimenting!

---

**Ready to create amazing guitar tones!** 🎸✨

Questions? Check the full documentation:
- **README.md** - Detailed overview
- **GUITAR_SAMPLER_PRESETS.md** - All 10 tone specifications
- **POLICE_SOUNDS.md** - Emergency effect presets & ideas
