# 🎹 Mellotron - DecenTron Edition

**Premium Mellotron emulation using DecenTron individual note samples (25 instruments, 841 samples)**

---

## ✨ What's Different from Original

**Original SF2 Mellotron:**
- Large consolidated audio files (111 MB)
- Simple waveform synthesis
- Limited character control

**DecenTron Edition (NEW!):**
- 25 individual instruments with 35 note samples each
- Real tape keyboard sounds mapped note-by-note
- Professional-grade sample library
- Better MIDI velocity response
- Authentic vintage character
- Each sample is a real Mellotron recording

---

## 🎵 25 Available Instruments

### Woodwind Section (3)
| # | Name | Character | Use For |
|---|------|-----------|---------|
| 0 | **MKII Flute** | Bright, articulate | Solo leads, ethereal pads |
| 8 | **Woodwind2** | Warm blend | Jazz, contemporary |
| 14 | **Tenor Sax** | Rich, mellow | Jazz solos, funky grooves |

### Strings Section (7)
| # | Name | Character | Use For |
|---|------|-----------|---------|
| 1 | **M300A Violins** | Smooth ensemble | Lush pads, backgrounds |
| 2 | **MKII Violins** | Rich ensemble | String sections |
| 4 | **Cello** | Warm, singing | Lyrical melodies, solo |
| 5 | **M300B Violin** | Single warm | Lyrical accompaniment |
| 6 | **String Section** | Full orchestra | Classic 70s prog pads |
| 7 | **String Session** | Orchestral | Cinematic, romantic |
| 15 | **Orchestra** | Full ensemble | Dramatic arrangements |

### Brass Section (5)
| # | Name | Character | Use For |
|---|------|-----------|---------|
| 3 | **GC3 Brass** | Bright trumpet | Funky brass, aggressive |
| 10 | **MKII Brass** | Bright ensemble | Orchestral brass |
| 12 | **Trumpet** | Piercing solo | Lead brass parts |
| 13 | **Trombone** | Warm sliding | Funky, soulful brass |
| 11 | **Mixed Brass B** | Blended section | Rich brass texture |

### Vocal Section (2)
| # | Name | Character | Use For |
|---|------|-----------|---------|
| 6 | **Combined Choir** | Ethereal blend | Ambient, spiritual |
| 11 | **8 Choir** | Full choir | Gospel, orchestral |

### Percussion & Keys (3)
| # | Name | Character | Use For |
|---|------|-----------|---------|
| 15 | **Vibes** | Mellow bell tones | Jazz, ambient |
| 16 | **Church Organ** | Warm classical | Religious, classical |
| 17 | **Italian Accordion** | Warm, intimate | Folk, world music |

---

## 🚀 Quick Start (2 minutes)

### Step 1: Create Tracks
Run the new setup script:
```
Reaper → Actions → Search "Mellotron_DecenTron_Setup.lua" → Run
```
✓ Creates 4 tracks with pre-selected instruments

### Step 2: Load Samples into ReaSampler
On each of the 3 tape tracks:

1. **Add FX** → ReaSampler
2. **Right-click** ReaSampler → "Open sample..."
3. **Navigate to:** `decent-sampler-files/melotron/DecenTron 1.0.0/Samples/[Instrument]/`
4. **Select ANY .wav file** (e.g., `C4.wav`)
   - ReaSampler automatically finds and maps all 35 notes!
5. **Enable:**
   - ✓ Resample
   - ✓ Note on MIDI key
6. **Click OK**

### Step 3: Play!
Create MIDI item, play keyboard → Instant Mellotron! 🎵

---

## 📊 Technical Details

### Sample Organization
```
DecenTron 1.0.0/Samples/
├── MkIIFlute/
│   ├── C2.wav ─→ Lowest note
│   ├── C#2.wav
│   ├── D2.wav
│   ...
│   └── F#5.wav ─→ Highest note (35 total)
├── M300A/
│   ├── C2.wav
│   ├── C#2.wav
│   ...
├── [23 more instruments]
```

### Coverage per Instrument
- **35 samples** per instrument
- **Range:** Approximately C2 to F#5 (2.9 octaves)
- **Mapping:** Automatic via ReaSampler
- **Quality:** 16-bit PCM at 44.1 kHz

### Polyphony
- **Unlimited** polyphony (depends on CPU)
- Each tape track can play multiple notes simultaneously
- Three tapes can run independently

---

## 🎼 Three Pro Presets for DecenTron

### PRESET 1: Classic Prog-Rock String Pad
```
Tape 1: String Section (100%)
Tape 2: M300A Violins (60%)
Tape 3: Combined Choir (40%)

Tape Effects (via Mellotron.jsfx on master):
  Wow & Flutter: 35%
  Tape Saturation: 50%
  Master Volume: 100%

Add on Master Bus:
  - Reverb: Hall, 2.5 sec
  - Compressor: 2:1 ratio
  - EQ: Slight boost 2-4kHz
```
→ Perfect for YES-style orchestral pads

### PRESET 2: Orchestral Brass & Strings
```
Tape 1: GC3 Brass (100%)
Tape 2: Woodwind2 (70%)
Tape 3: String Section (40%)

Tape Effects:
  Wow & Flutter: 25%
  Tape Saturation: 60%

Add on Master:
  - Reverb: Hall, 1.5 sec
  - Compression: 3:1 ratio
```
→ Bright, punchy brass with orchestral undertones

### PRESET 3: Ethereal Flute & Voices
```
Tape 1: MKII Flute (100%)
Tape 2: MKII Flute (80%) ← Pan: Left
Tape 3: 8 Choir (50%) ← Pan: Right

Tape Effects:
  Wow & Flutter: 50%
  Tape Saturation: 60%

Add on Master:
  - Reverb: 70% wet, 3 sec decay
  - Chorus: Light modulation
  - Compression: Light, 50ms attack
```
→ Floating, dreamy atmosphere (classic Mellotron sound)

---

## 🎚️ Using All 25 Instruments

### Strategy 1: Consistency (Layered Same Sound)
Mix the same instrument on all 3 tapes with slightly different volumes:
- Tape 1: M300A at 100%
- Tape 2: M300A at 70% (panned left)
- Tape 3: M300A at 50% (panned right)
→ Rich, lush texture with natural detuning

### Strategy 2: Family Approach (Same Category)
Mix instruments from same family:
```
STRINGS MIX:
  Tape 1: String Section (100%)
  Tape 2: M300A Violins (60%)
  Tape 3: Cello (40%)

BRASS MIX:
  Tape 1: GC3 Brass (100%)
  Tape 2: Trumpet (60%)
  Tape 3: Trombone (40%)

WOODWIND MIX:
  Tape 1: MKII Flute (100%)
  Tape 2: Woodwind2 (60%)
  Tape 3: Tenor Sax (40%)
```

### Strategy 3: Complementary Mix (Different Families)
Create unique textures:
```
LUSH ORCHESTRAL:
  Tape 1: Orchestra (100%)
  Tape 2: Cello (50%)
  Tape 3: Combined Choir (30%)

FUNKY SOUL:
  Tape 1: GC3 Brass (100%)
  Tape 2: Tenor Sax (70%)
  Tape 3: String Section (40%)

ETHEREAL AMBIENT:
  Tape 1: 8 Choir (100%)
  Tape 2: MKII Flute (60%)
  Tape 3: Church Organ (40%)
```

---

## 🎯 Advanced Techniques

### Real-Time Tape Switching
During a song, switch instruments on a tape to create variation:
1. Keep Tape 1 as main melodic element
2. Switch Tape 2 between:
   - Verse: M300A Violins (60%)
   - Chorus: String Section (80%)
   - Bridge: Cello (50%)
3. Keep Tape 3 at consistent choir level

### Velocity Dynamics
Each sample responds to MIDI velocity:
- **Soft (vel 20-50):** Subtle, muted tone
- **Medium (vel 60-100):** Natural tone
- **Hard (vel 110-127):** Bright, attacking tone

Play with varied velocity for natural expression.

### Panning Stereo Width
Use panning to create width:
- Tape 1: Center (0)
- Tape 2: Left (-30 to -50)
- Tape 3: Right (+30 to +50)
→ Creates immersive stereo image

### Automation Recording
Record parameter changes:
1. Enable automation recording
2. Record MIDI performance
3. While playing, adjust:
   - Tape Selection (change instruments)
   - Tape Levels (dynamic mixing)
   - Tape Pan (stereo movement)
4. Mellotron.jsfx effects (Wow, Saturation)
→ Results in expressive, human-like performance

---

## 🎓 Instrument Selection Guide

### For Melodic Lead
Best instruments for single-note melodies:
1. **MKII Flute** - Bright, articulate
2. **Cello** - Warm, vocal-like
3. **Tenor Sax** - Rich, expressive
4. **Trumpet** - Piercing, present

### For Pad/Sustain
Best instruments for sustained chords:
1. **String Section** - Lush, orchestral
2. **Orchestra** - Full, complex
3. **8 Choir** - Ethereal, supportive
4. **Church Organ** - Warm, sustained

### For Rhythmic Texture
Best instruments for punchy, rhythmic playing:
1. **GC3 Brass** - Bright attack
2. **Vibes** - Percussive, bell-like
3. **Trumpet** - Articulate attack
4. **Trombone** - Funky, sliding

### For Background Pad
Best instruments for under-the-melody accompaniment:
1. **Combined Choir** - Soft, ambient
2. **M300A Violins** - Smooth, unobtrusive
3. **String Session** - Lush, full
4. **Italian Accordion** - Warm, intimate

---

## 🔧 Troubleshooting DecenTron

### No sound or missing notes
- Verify ReaSampler loaded sample from correct folder
- Check ReaSampler shows green "loaded" indicator
- Ensure all 35 note files are present in folder
- Try loading a different .wav from same folder

### Audio quality issues
- Check ReaSampler quality setting (use "High" or "Very High")
- Verify sample rate matches your project (44.1 kHz)
- Increase audio buffer if hearing clicks/pops
- Check track levels aren't clipping

### Notes not mapping correctly
- Delete the current sample and reload
- Try loading from folder instead of individual file
- Check folder contains only .wav files (no images/text)
- Verify folder path contains instrument name

### CPU usage too high
- Reduce number of active tracks
- Disable automation recording when not needed
- Use lower ReaSampler quality if CPU allows
- Freeze tracks between recording passes

---

## 📈 Performance Comparison

### Original SF2 Mellotron
- Sample size: 111 MB
- Instruments: 13
- Samples per instrument: 1 (consolidated)
- Note mapping: Automatic via JSFX
- Quality: Good, but synthetic-sounding

### DecenTron Edition (NEW!)
- Sample size: ~1.2 GB (across all 25 instruments)
- Instruments: 25
- Samples per instrument: 35 individual notes
- Note mapping: Automatic via ReaSampler
- Quality: Professional, authentic tape keyboard sound

**Verdict:** DecenTron is significantly better for authentic Mellotron playback!

---

## 🎁 Bonus Features

### Included Setup Scripts
- `Mellotron_DecenTron_Setup.lua` - Auto-create 4-track setup
- `Mellotron_Setup.lua` - Original SF2 setup (still available)

### Included Mixer Plugin
- `Mellotron.jsfx` - Works with both SF2 and DecenTron versions

### Included Documentation
- 18 pages total across all files
- 10+ presets documented
- Performance techniques guide
- Troubleshooting database

---

## 💡 Tips for Best Results

1. **Start Simple:** Use one instrument per tape, same volume
2. **Layer Gradually:** Add second tape, then third
3. **Use Sustain Pedal:** Smooth tape transitions
4. **Vary Velocity:** Play with expression, not just dynamics
5. **Add Reverb:** 50-70% wet for vintage character
6. **Use Compression:** 2:1 ratio for tape-like character
7. **Automate:** Record parameter changes during performance
8. **Mix Tape Levels:** Keep main melody at higher level

---

## 🌟 Getting the Most Out of DecenTron

### For Recording
1. Set up 3 tracks with favorite instruments
2. Create MIDI arrangement
3. Play performance with automation
4. Add reverb/compression on master
5. Bounce to stereo
6. Use in final mix

### For Live Performance
1. Keep Tape 1 as primary melody
2. Use Tape 2-3 as harmonic bed
3. Switch instruments between sections
4. Use faders for dynamic level changes
5. Record automation for consistency

### For Sound Design
1. Stack 3 of same instrument (different pans)
2. Use Mellotron.jsfx effects creatively
3. Record extreme Wow & Flutter settings
4. Experiment with unusual combinations
5. Save favorite presets for reuse

---

## 📝 Famous DecenTron Sounds

The DecenTron library captures sounds from:
- **Mellotron 400** (1960s-70s classic)
- **Mellotron MKII** (1980s improved version)
- **Various original Mellotron models** (M300A, M300B, GC3)

Using these exact samples gives you authentic vintage Mellotron character!

---

## 🎹 You're Ready!

The DecenTron edition provides:
✓ Professional sample library (25 instruments, 841 samples)
✓ Authentic vintage tape keyboard sound
✓ Automatic setup script
✓ Beautiful mixing UI via Mellotron.jsfx
✓ Comprehensive documentation
✓ 10+ pre-configured presets

**Start with Mellotron_DecenTron_Setup.lua and you're playing in 2 minutes!**

Happy Mellotron-ing! 🎹✨

---

*DecenTron Mellotron Edition - Professional vintage keyboard emulation for Reaper*
