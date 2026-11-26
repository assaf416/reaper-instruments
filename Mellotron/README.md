# 🎹 Reaper Mellotron - Professional 3-Tape Mixer Instrument

> **Current layout:** this folder is self-contained. Run `Install-Mellotron.ps1` (or `..\Install-All.ps1`) and add the
> **Mellotron** JSFX to a track. `Mellotron.jsfx` now plays the DecenTron samples in `samples\DecenTron` directly
> (no ReaSampler needed), has a clickable graphic UI (tape selector per panel, level / pan / wow / saturation knobs; same look as the other instruments, after the chmaha Jexed and JamSynth panels), and a demo
> project in `projects\`. The guides in `docs\` describe the original ReaSampler-based setup and are kept for reference.

A vintage Mellotron emulation for Reaper with **three simultaneous tape selections**, **beautiful mixing UI**, and support for 25 authentic tape keyboard sounds from the DecenTron sample library.

![Mellotron UI Preview](WURLITZER.png)

## ✨ Features

- **3-Tape Independent Mixing** - Mix up to three different Mellotron sounds simultaneously
- **25 Authentic Instruments** - From DecenTron professional sample library
- **Beautiful UI** - Vintage-inspired mixer with real-time level/pan controls
- **Tape Effects** - Wow & Flutter for vintage pitch instability, Tape Saturation for warmth
- **Full MIDI Support** - Velocity-sensitive playback, sustain pedal compatible
- **841 Professional Samples** - 35 note samples per instrument, fully mapped to MIDI keys
- **10+ Pre-configured Presets** - Ready-to-use sounds from YES to King Crimson
- **Zero Learning Curve** - One-click automatic setup script

## 🚀 Quick Start

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/assaf416/reaper-instruments.git
   cd reaper-instruments
   ```

2. Copy files to your Reaper resources:
   - `Mellotron.jsfx` → Reaper FX directory
   - `Mellotron_DecenTron_Setup.lua` → Reaper Scripts directory
   - Documentation files → Keep in your project folder

3. **Get the sample library** (see below for options)

### Setup (90 seconds)

In Reaper:
1. **Tools** → **Run Script** → Select `Mellotron_DecenTron_Setup.lua`
2. ✓ 4 tracks created automatically (Master + 3 Tapes)
3. Add **ReaSampler** to each tape track
4. Load samples from: `DecenTron 1.0.0/Samples/[Instrument]/`
5. Create MIDI item and start playing! 🎵

**For detailed instructions, see [DECENTRON_QUICK_START.txt](DECENTRON_QUICK_START.txt)**

## 📚 Documentation

| File | Purpose |
|------|---------|
| **[START_HERE.md](START_HERE.md)** | Quick overview & 60-second setup |
| **[DECENTRON_QUICK_START.txt](DECENTRON_QUICK_START.txt)** | 2-minute step-by-step guide |
| **[DECENTRON_MELLOTRON_GUIDE.md](DECENTRON_MELLOTRON_GUIDE.md)** | Complete manual (25 instruments) |
| **[MELLOTRON_README.md](MELLOTRON_README.md)** | Full user guide |
| **[MELLOTRON_PRESETS.txt](MELLOTRON_PRESETS.txt)** | 10 famous presets + techniques |
| **[MELLOTRON_SETUP_VISUAL.txt](MELLOTRON_SETUP_VISUAL.txt)** | Visual diagrams & ASCII art |
| **[QUICK_REFERENCE.txt](QUICK_REFERENCE.txt)** | Cheat sheet (printable) |

## 🎵 Sample Libraries

### Option 1: DecenTron Professional Library (Recommended!)

**Download DecenTron 1.0.0** from [Decent Sampler](https://www.decentsamples.com/product/decentron/)

Extract to your project folder:
```
reaper-instruments/
└── decent-sampler-files/
    └── melotron/
        └── DecenTron 1.0.0/
            └── Samples/
                ├── MkIIFlute/ (35 samples)
                ├── M300A/ (35 samples)
                ├── StringSection/ (35 samples)
                └── [22 more instruments]
```

**Features:**
- 25 instruments with 35 notes each
- 841 professional recordings
- Authentic vintage tape keyboard sound
- Automatic MIDI note mapping

### Option 2: Original SF2 Mellotron

If you already have Mellotron SF2 soundfonts, use `Mellotron_Setup.lua` instead.

## 🎼 Three Favorite Presets

### Preset 1: Classic Prog-Rock (YES Style)
```
Tape 1: String Section (100%)
Tape 2: M300A Violins (60%)
Tape 3: Combined Choir (40%)
Effects: Reverb on master (50% wet, 2.5 sec)
→ Lush, orchestral pad sound
```

### Preset 2: Orchestral Brass
```
Tape 1: GC3 Brass (100%)
Tape 2: Woodwind2 (70%)
Tape 3: String Section (40%)
Effects: Compression, hall reverb
→ Bright brass with orchestral undertones
```

### Preset 3: Ethereal Flute
```
Tape 1: MKII Flute (100%)
Tape 2: MKII Flute (80%) Pan: Left
Tape 3: 8 Choir (50%) Pan: Right
Effects: Heavy reverb (70% wet)
→ Floating, atmospheric Mellotron sound
```

[See MELLOTRON_PRESETS.txt for 7 more presets]

## 🎹 25 Available Instruments

| Category | Instruments | Use For |
|----------|-------------|---------|
| **Woodwind** | MKII Flute, Woodwind2, Tenor Sax | Leads, pads |
| **Strings** | M300A, MKII Violins, Cello, String Section, String Session, Orchestra | Lush pads, orchestral |
| **Brass** | GC3 Brass, MKII Brass, Trumpet, Trombone, Mixed Brass | Funky, bright |
| **Vocal** | Combined Choir, 8 Choir | Ethereal, ambient |
| **Percussion** | Vibes, Church Organ, Italian Accordion | Color, texture |

## 🎚️ Main Controls

### Tape Selection (Sliders 1-3)
Choose which Mellotron instrument for each channel (0-24)

### Level & Pan (Sliders 4-9)
Mix volume (0-100%) and stereo position (-100 Left to +100 Right)

### Tape Characteristics
- **Wow & Flutter (0-100%)**: Vintage pitch wobble
- **Tape Saturation (0-100%)**: Harmonic warmth
- **Master Volume**: Overall level

## 🛠️ System Requirements

- **Reaper** 6.0+ (Windows, Mac, Linux)
- **ReaSampler** (included with Reaper)
- **JSFX support** (default enabled)
- **Disk space**: ~1.2GB for DecenTron samples
- **CPU**: Minimal (mostly disk streaming)

## 📝 Historical Context

The Mellotron (1963) was a revolutionary keyboard that played tape loops of real instruments. This emulation captures that magic using:
- Professional sample library from Decent Sampler
- Real Mellotron tape keyboard recordings
- Authentic vintage character with Wow & Flutter
- Three-tape simultaneous mixing (like pressing three keys at once)

**Featured in:** YES, King Crimson, Genesis, Emerson Lake & Palmer, The Moody Blues

## 🤝 Contributing

Improvements welcome! Please open issues or pull requests for:
- Additional presets
- Performance enhancements
- Documentation improvements
- UI/UX suggestions

## 📄 License

This project is provided as-is for personal and professional use.

The DecenTron sample library is provided by [Decent Samples](https://www.decentsamples.com/) and subject to their license terms.

## 🎓 Learning Resources

- **Quick Start**: [DECENTRON_QUICK_START.txt](DECENTRON_QUICK_START.txt)
- **Full Manual**: [DECENTRON_MELLOTRON_GUIDE.md](DECENTRON_MELLOTRON_GUIDE.md)
- **Presets & Techniques**: [MELLOTRON_PRESETS.txt](MELLOTRON_PRESETS.txt)
- **Performance Guide**: [MELLOTRON_README.md](MELLOTRON_README.md)

## 🎵 Getting Started

**Start here:** Read [START_HERE.md](START_HERE.md)

You'll be playing the Mellotron in under 3 minutes!

## 🎹 You're Ready!

The Mellotron is a professional-grade instrument ready to use:
✓ Beautiful mixer UI  
✓ 25 authentic instruments  
✓ 841 professional samples  
✓ Automatic setup script  
✓ Comprehensive documentation  
✓ 10+ presets ready to use  

**Run `Mellotron_DecenTron_Setup.lua` in Reaper and start making music!**

---

**Happy Mellotron-ing!** 🎹✨

*Professional vintage keyboard emulation for Reaper*
