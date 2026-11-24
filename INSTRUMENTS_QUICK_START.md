# All Instruments - Quick Access Guide

**Status: 6/9 instruments fully installed** ✓

---

## ✅ INSTALLED & READY TO USE

### 1️⃣ MELLOTRON (Lush String Pad)
- **Type**: JSFX Synthesizer
- **Access**: FX → Add → JS → Mellotron
- **Features**: 3-tape mixer, wow & flutter, tape saturation
- **Presets**: Built into UI
- **Demo Track**: "1. Mellotron - Lush String Pad" in MASTER_DEMO_All_Instruments_v2.rpp

### 2️⃣ ORGAN (Hammond-Style with 36 Presets)
- **Type**: JSFX Synthesizer
- **Access**: FX → Add → JS → Organ
- **Features**: 9 drawbars, vibrato/chorus, Leslie rotary speaker, percussion
- **Presets**: 
  - Buttons on UI for presets 1-20
  - MIDI Program Change (21-36) for legendary keyboardists
- **Demo Track**: "2. Organ - Rick Wakeman Owner of a Lonely Heart"

### 3️⃣ PIANO (Acoustic Piano)
- **Type**: JSFX Synthesizer
- **Access**: FX → Add → JS → Piano
- **Features**: Realistic piano sound with velocity control
- **Presets**: Via FX Preset system
- **Demo Track**: "3. Piano - Warm Acoustic"

### 4️⃣ SYNTH (RetroSynth - 50 Presets)
- **Type**: JSFX Synthesizer
- **Access**: FX → Add → JS → RetroSynth
- **Features**: 2 oscillators, 4-pole filter, chorus, delay, reverb
- **Presets**: 50 presets in UI slider (0-49)
  - 0-33: Original presets (pads, leads, bass, keys)
  - 34-49: Analog Legends (Rick Wakeman, Pink Floyd, Keith Emerson, etc.)
- **Demo Tracks**: 
  - "4. Synth - Gilmour Shine Lead"
  - "7. Synth Pad - Queen Lush"
  - "8. Lead Synth - Hendrix Fuzz"

### 5️⃣ GUITAR (Lead & Bass Synth)
- **Type**: JSFX Synthesizer
- **Access**: FX → Add → JS → Guitar
- **Features**: Lead synth with guitar-like envelopes
- **Presets**: Via FX Preset system
- **Demo Track**: "5. Guitar - Gilmour Warm Lead"

### 6️⃣ DRUMS (Percussion Synthesizer)
- **Type**: JSFX Synthesizer
- **Access**: FX → Add → JS → Drums
- **Features**: Drum sound synthesis
- **Demo Track**: Built into demo project
- **Note**: Trigger via MIDI notes for different drum sounds

---

## ⚠️ PARTIALLY INSTALLED (Need Guitar Station S2 plugin)

### 7️⃣ BASS RIG (FX Chain)
- **Type**: FX Chain (EQ, Compression, Effects)
- **Access**: Right-click track FX → Load FX Chain → Bass Rig.RfxChain
- **Status**: ✓ FX Chain installed
- **Note**: Works with any bass synth or sampler

### 8️⃣ GUITAR RIG (10 Legendary Tone Presets)
- **Type**: FX Chain + Guitar Station S2 (Tukan Studios)
- **Access**: Right-click track FX → Load FX Chain → Guitar + Rig.RfxChain
- **Status**: ⚠️ FX Chain installed, but needs **Guitar Station S2 plugin**
- **Presets**: 10 legendary guitar tones
  1. Gilmour (Warm Sustaining Lead)
  2. Beatles (Jangly Bright Clean)
  3. Hendrix (Heavy Fuzz & Sustain)
  4. Deep Purple (Thick Overdrive)
  5. Iron Maiden (Bright Metal Crunch)
  6. Nirvana (Grunge Wall of Sound)
  7. Queen (Lush & Orchestral)
  8. Dire Straits (Clean Strat Warmth)
  9. Metallica/Megadeth (High-Gain Metal)
  10. Rage Against Machine (Heavy & Experimental)
- **Documentation**: See `GuitarRig/GUITAR_LEGENDS.md`

### 9️⃣ GUITAR SAMPLER (Sample-Based Guitar + Police Sounds)
- **Type**: ReaSampler + Guitar Station S2 (Tukan Studios)
- **Status**: ⚠️ Needs **Guitar Station S2 plugin**
- **Setup**: Manual - Add ReaSampler, then add Guitar Station S2
- **Samples**: Located in `GuitarSampler/samples/Guitars/`
- **Features**:
  - 10 legendary guitar tone presets
  - Police siren & emergency sound effects
- **Documentation**: See `GuitarSampler/QUICK_START.md`

---

## 🔧 MISSING THIRD-PARTY PLUGIN

**Guitar Station S2 (Tukan Studios)**
- Required for: GuitarRig & GuitarSampler
- Status: **NOT INSTALLED** ❌
- Impact: GuitarRig and GuitarSampler presets won't work without it
- Solution: 
  1. Download from Tukan Studios website
  2. Install to your Reaper VST/VST3 directory
  3. Rescan plugins in Reaper (Options → Rescan plugins)

---

## 🎹 HOW TO USE IN REAPER

### Add a JSFX Instrument:
1. Create new track: **Track → Insert new track**
2. Click **FX** button on track
3. Click **Add** (or green +)
4. Search/Browse: **JS** → Select instrument (Mellotron, Organ, Piano, RetroSynth, Guitar, Drums)
5. Done! Now play via MIDI keyboard

### Load an FX Chain:
1. Create new track
2. Click **FX** button
3. Right-click in FX window
4. **Load FX Chain** → Navigate to:
   - `Bass Rig.RfxChain` or
   - `Guitar + Rig.RfxChain`
5. Done!

### Access Presets:
- **RetroSynth**: Use Preset slider in UI (0-49)
- **Organ**: Click preset buttons on UI (1-20), or send MIDI CC for 21-36
- **Other JSFX**: Right-click plugin → Load FX Preset

---

## 📂 FILE LOCATIONS

| Item | Location |
|------|----------|
| **JSFX Plugins** | `~/.config/REAPER/Effects/` |
| **FX Chains** | `~/.config/REAPER/Effects/Bass/` and `.../Guitar/` |
| **Samples** | `GuitarSampler/samples/` |
| **Documentation** | `GuitarRig/`, `GuitarSampler/` folders |

---

## ✨ NEXT STEPS

1. **Open demo project**: MASTER_DEMO_All_Instruments_v2.rpp
2. **Try each track**: Play keyboard to hear each instrument
3. **Explore presets**: Try different presets on RetroSynth and Organ
4. **Create new project**: Build your own song using these instruments

**To enable full guitar presets**: Install Guitar Station S2 plugin from Tukan Studios

---

**All 6 core instruments are ready to use right now!** 🎵
