# 📦 Sample Files Guide

This repository contains all the **code, scripts, and documentation** for the Reaper Mellotron instrument. The **sample files are stored separately** due to their large size (~1.2GB).

## 🎵 Sample Libraries

### Option 1: DecenTron Professional Library (Recommended!)

**Download location:** [Decent Sampler - DecenTron](https://www.decentsamples.com/product/decentron/)

**Free download** (or pay-what-you-want)

**Contents:**
- 25 Mellotron instruments
- 35 note samples per instrument
- 841 total professional recordings
- Pre-mapped for automatic MIDI note playback

**Setup:**
1. Download DecenTron 1.0.0 from Decent Sampler
2. Extract to this repository:
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
3. Run `Mellotron_DecenTron_Setup.lua` in Reaper
4. Done! 🎵

### Option 2: Original Mellotron SF2 Soundfont

If you have Mellotron SoundFont files, you can use the original `Mellotron_Setup.lua` script instead.

**Supported SF2 files:**
- Mellotron.sf2
- Mellotron M300/M400 variants
- Other vintage Mellotron soundfonts

**Setup:**
1. Place SF2 files in: `samples/`
2. Run `Mellotron_Setup.lua` in Reaper
3. Done!

### Option 3: Wurlitzer Electric Piano

Bonus samples included for Wurlitzer electric piano:
- **Location:** `samples/wurly_el_piano*.wav`
- **Count:** 75 individual note samples
- **Use:** Create a Wurlitzer instrument using ReaSampler

## 📊 File Sizes

| Item | Size | Type |
|------|------|------|
| DecenTron Samples | ~1.2 GB | Audio (WAV) |
| Original Mellotron SF2 | 111 MB | Soundfont |
| Wurlitzer Samples | ~50 MB | Audio (WAV) |
| **Code & Docs** | ~20 MB | Scripts & Markdown |

**Total with all samples:** ~1.4 GB

## 🔧 Installation Guide

### Quick Install (5 minutes)

1. **Clone this repository**
   ```bash
   git clone https://github.com/assaf416/reaper-instruments.git
   cd reaper-instruments
   ```

2. **Download DecenTron**
   - Visit: https://www.decentsamples.com/product/decentron/
   - Download "DecenTron 1.0.0"
   - Extract to: `reaper-instruments/decent-sampler-files/`

3. **Copy JSFX plugin**
   ```bash
   cp Mellotron.jsfx ~/Library/Application\ Support/REAPER/FX/
   # or on Windows: 
   # copy Mellotron.jsfx "%APPDATA%\REAPER\FX\"
   ```

4. **Copy Lua scripts**
   ```bash
   cp Mellotron_DecenTron_Setup.lua ~/Library/Application\ Support/REAPER/Scripts/
   cp Mellotron_Setup.lua ~/Library/Application\ Support/REAPER/Scripts/
   # or on Windows:
   # copy Mellotron_DecenTron_Setup.lua "%APPDATA%\REAPER\Scripts\"
   ```

5. **In Reaper:**
   - Open or create a project
   - **Tools** → **Run Script** → Select `Mellotron_DecenTron_Setup.lua`
   - Add ReaSampler to each tape track
   - Load samples from `DecenTron 1.0.0/Samples/[Instrument]/`
   - Play! 🎵

## 🎯 Directory Structure (After Setup)

```
reaper-instruments/
├── README.md                           (This file)
├── SAMPLES.md                          (This guide)
├── START_HERE.md                       (Quick overview)
├── DECENTRON_QUICK_START.txt          (2-minute setup)
├── DECENTRON_MELLOTRON_GUIDE.md       (Full manual)
├── MELLOTRON_PRESETS.txt              (10 presets)
├── Mellotron.jsfx                     (Mixer plugin)
├── Mellotron_DecenTron_Setup.lua      (Setup script)
├── Mellotron_Setup.lua                (Alternative setup)
│
├── decent-sampler-files/              (Download from Decent Sampler)
│   └── melotron/
│       └── DecenTron 1.0.0/
│           └── Samples/
│               ├── MkIIFlute/         (35 samples)
│               ├── M300A/             (35 samples)
│               ├── StringSection/     (35 samples)
│               └── [22 more]
│
└── samples/                            (Optional - for SF2 or extras)
    ├── Mellotron/
    ├── Full_Grand_Piano/
    └── wurly_el_piano*.wav
```

## ⚠️ Troubleshooting

### "Can't find samples" error
- Verify DecenTron extracted correctly
- Check folder path: `decent-sampler-files/melotron/DecenTron 1.0.0/Samples/`
- Each instrument folder should contain 35 .wav files
- Verify file names (C2.wav, C#2.wav, D2.wav, etc.)

### No sound in ReaSampler
- Right-click ReaSampler: "Open sample..."
- Navigate to: `DecenTron 1.0.0/Samples/[Instrument]/`
- Select ANY .wav file (e.g., C4.wav)
- ReaSampler auto-maps all 35 notes
- Enable ✓ Resample
- Enable ✓ Note on MIDI key
- Click OK

### "File too large" error
- Some sample directories exceed 100 MB
- This is normal - each folder contains ~35 samples
- Reaper handles this automatically

## 📥 Git Large File Storage (Optional)

For future versions using git-lfs:

```bash
git lfs install
git lfs track "*.wav"
git add .gitattributes
```

This allows storing large audio files directly in git.

## 🔄 Updating Samples

To use different sample libraries:

1. Remove/replace the `decent-sampler-files/` or `samples/` folder
2. Add your new sample library
3. Run the appropriate setup script
4. Load samples into ReaSampler

## 📖 Documentation

All documentation is included in the repository:

- **[README.md](README.md)** - Main overview
- **[START_HERE.md](START_HERE.md)** - Quick start (60 seconds)
- **[DECENTRON_QUICK_START.txt](DECENTRON_QUICK_START.txt)** - Step-by-step (2 minutes)
- **[DECENTRON_MELLOTRON_GUIDE.md](DECENTRON_MELLOTRON_GUIDE.md)** - Complete manual
- **[MELLOTRON_PRESETS.txt](MELLOTRON_PRESETS.txt)** - 10 presets + techniques

## ✨ What You Get

**Code (in this repository):**
- Mellotron.jsfx - Beautiful mixer UI
- Setup scripts (Lua) - Automatic track creation
- Complete documentation (18 pages)
- 10+ pre-configured presets

**Samples (download separately):**
- 25 Mellotron instruments
- 841 professional recordings
- Full MIDI note mapping

## 🚀 Next Steps

1. **Clone this repository**
2. **Download DecenTron** from Decent Sampler
3. **Extract to** `reaper-instruments/decent-sampler-files/`
4. **Read** [START_HERE.md](START_HERE.md)
5. **Run** Mellotron_DecenTron_Setup.lua in Reaper
6. **Play!** 🎵

## 📞 Need Help?

- Check [DECENTRON_QUICK_START.txt](DECENTRON_QUICK_START.txt) for step-by-step instructions
- See [MELLOTRON_README.md](MELLOTRON_README.md) for troubleshooting
- Read [DECENTRON_MELLOTRON_GUIDE.md](DECENTRON_MELLOTRON_GUIDE.md) for complete reference

## 📝 License

- **Code**: MIT License (use freely)
- **DecenTron Samples**: Subject to [Decent Sampler terms](https://www.decentsamples.com)
- **Documentation**: CC-BY-SA 4.0

---

**Happy Mellotron-ing!** 🎹✨
