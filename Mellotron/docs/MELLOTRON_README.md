# Mellotron - Reaper Instrument

A vintage Mellotron emulation for Reaper with **three simultaneous tape selections** and beautiful mixing interface.

## 🎹 Features

- **3-Tape Mixer**: Mix three different vintage keyboard tapes simultaneously
- **13 Mellotron Sounds**: Flute, Cello, Violins, Brass, Choir, Woodwind, and more
- **Tape Characteristics**: 
  - Wow & Flutter for vintage pitch instability
  - Tape Saturation for warm, colored tone
  - Individual pan controls per tape
- **Beautiful UI**: Vintage-inspired interface showing tape selection and mixing levels
- **Full MIDI Support**: Play with keyboard, mouse, or any MIDI controller

## 📦 What's Included

- `Mellotron.jsfx` - Main mixing/effect plugin with UI
- `Mellotron_Setup.lua` - Script to create organized track setup
- `samples/Mellotron/sample_000.wav` - Extracted Mellotron tape samples

## 🚀 Quick Start

### Option 1: Automatic Setup (Recommended)

1. Open Reaper
2. Go to `Actions > Show action list`
3. Search for "Mellotron_Setup.lua" or use: `Script: Mellotron_Setup.lua`
4. The script will create a 3-track Mellotron instrument automatically

### Option 2: Manual Setup

1. **Create 3 tracks** (or use the setup script above)
2. **On each track**, add the `ReaSampler` plugin:
   - Track 1: Effects > Add FX > ReaSampler
   - Track 2: Effects > Add FX > ReaSampler
   - Track 3: Effects > Add FX > ReaSampler

3. **Load samples into each ReaSampler**:
   - Open ReaSampler
   - Right-click > Open sample
   - Navigate to: `samples/Mellotron/sample_000.wav`
   - Enable "Resample" option
   - Set pitch mode to respond to MIDI

4. **Add the Mellotron mixer plugin** to your master bus:
   - Master bus > Add FX > Mellotron.jsfx

5. **Route each track to master bus**:
   - Track 1: Output to Master
   - Track 2: Output to Master
   - Track 3: Output to Master

## 🎚️ Controls

### Tape Selection (Sliders)
- **Tape 1, 2, 3**: Select different tape sounds for each channel
  - 0: MKII Flute
  - 1: M400 Cello
  - 2: MKII 3 Violins
  - 3: Gc3 Brass
  - 4: Gong
  - 5: M300A Violins
  - 6: M300B Violin
  - 7: M400 Choir
  - 8: M400 String Section
  - 9: M400 Woodwind2
  - 10-12: More variations

### Level Controls
- **Tape 1/2/3 Level**: Mix the volume of each tape (0-100%)
- **Pan**: Position each tape in the stereo field (-100 = left, +100 = right)

### Tape Characteristics
- **Wow & Flutter** (0-100%): Adds pitch instability for vintage character
  - 0% = Perfect digital pitch
  - 50% = Natural tape wobble
  - 100% = Heavy warping
  
- **Tape Saturation** (0-100%): Adds harmonic coloration and warmth
  - 0% = Clean digital
  - 50% = Warm analog
  - 100% = Heavy distortion

- **Master Volume**: Overall output level

## 🎼 Tips & Tricks

### Classic Mellotron Sounds

**String Section**: 
- Tape 1: M400 Violins (100%)
- Tape 2: M400 Cello (70%)
- Tape 3: Off

**Rich Brass**:
- Tape 1: Gc3 Brass (100%)
- Tape 2: Woodwind (50%)
- Tape 3: Off

**Ethereal Flute Pad**:
- Tape 1: MKII Flute (100%)
- Tape 2: MKII Flute (80%) - pitch slightly detune
- Tape 3: Choir (40%) - for ambient texture

### Tape Characteristics Tips

**Warm Vintage Tone**:
- Wow: 30-40%
- Saturation: 50%

**Lo-Fi Character**:
- Wow: 60-80%
- Saturation: 80%

**Modern Clean**:
- Wow: 0-10%
- Saturation: 0-20%

## 🔧 Customization

### Add Effects to Master Bus

For authentic Mellotron sound, add effects in this order:
1. **EQ**: Boost 2-4kHz for presence, roll off above 10kHz
2. **Chorus**: Classic tape wobble simulation
3. **Reverb**: Spring or hall reverb for 1970s room sound
4. **Compression**: Light (2:1) compression for tape-like character
5. **Saturator**: Optional 2nd stage for extra warmth

### MIDI Techniques

**Legato Playing**: 
- Use overlapping notes for smooth tape transitions

**Velocity Dynamics**:
- Play lightly (velocity 1-50) for muted tones
- Full velocity (120-127) for bright attacks

**Layering**:
- Keep Tape 1 as main melodic element
- Use Tapes 2-3 as harmonic/textural layers

## 📊 System Requirements

- **Reaper** 6.0+
- **ReaSampler** (included with Reaper)
- **JSFX Support** (enabled by default)
- CPU: Minimal (mostly disk streaming audio)
- Disk Space: ~128MB for extracted samples

## 🎓 Understanding Mellotrons

The original Mellotron (1963) was a keyboard that played pre-recorded tape loops of real instruments. Each key had a small tape loop underneath - pressing a key would play the tape forward, releasing would rewind it.

This emulation reproduces that experience by:
- Using extracted samples from professional Mellotron soundfonts
- Allowing 3 simultaneous tapes (like pressing 3 keys at once)
- Adding "Wow & Flutter" for authentic tape instability
- Using saturation for the warm, slightly compressed tape character

## 🐛 Troubleshooting

**No sound?**
- Check ReaSampler is enabled on each track
- Verify sample file is loaded (green indicator in ReaSampler)
- Check track volumes aren't at minimum

**Clicking/pops?**
- Reduce Wow & Flutter
- Check ReaSampler resample quality setting
- Increase audio buffer size

**JSFX won't load?**
- Reaper may need restart
- Check JSFX are enabled: Options > Show JSFX browser
- Try dragging Mellotron.jsfx directly to master track

## 📝 Credits

- Mellotron instrument design & UI: Claude AI
- Sample extraction from: Mellotron.sf2 soundfont
- Reaper integration: Lua scripting

## 📄 License

Free to use and modify. Share improvements!

---

**Happy Mellotron-ing!** 🎹✨
