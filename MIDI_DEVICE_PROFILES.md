# MIDI Device Profiles - Specialized Mappings

Professional setup for 4 keyboards/controllers with specific instrument assignments.

---

## 🎵 Device Assignment Overview

| Device | Primary Use | Secondary | Tertiary |
|--------|------------|-----------|----------|
| **M-Audio Oxygen Pro Mini** | Organ (Drawbars) | All instruments | General control |
| **M-Wave SMC-Mixer** | Organ (Drawbars) | Master mixing | Volume control |
| **M-Audio Axiom 61** | Organ (Drawbars) | Full keyboard | Secondary synth |
| **Drum Pads (GO:3/Nano/Axiom)** | Drums instrument | | |

---

## 1️⃣ M-WAVE SMC-MIXER → ORGAN (Hammond Drawbars)

**Primary Purpose:** Dedicated 8-fader drawbar controller

### Hardware Setup
- **8 Faders:** Fully dedicated to drawbars
- **8 Rotary Encoders:** Available for effects
- **43 Buttons:** Optional for preset switching

### MIDI CC Mapping

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FADERS (Primary - Drawbars):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Fader 1 (CC7):    16' foot drawbar (sub-bass)
Fader 2 (CC10):   5⅓' foot drawbar (bass)
Fader 3 (CC12):   8' foot drawbar (fundamental)
Fader 4 (CC13):   4' foot drawbar (upper mid)
Fader 5 (CC14):   2⅔' foot drawbar (presence)
Fader 6 (CC15):   2' foot drawbar (bright)
Fader 7 (CC16):   1⅗' foot drawbar (sparkle)
Fader 8 (CC17):   1⅓' foot drawbar (shimmer)

Note: 9th drawbar (1') can be mapped to optional 9th fader
      or integrated into encoder control

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROTARY ENCODERS (Secondary - Effects):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Encoder 1 (CC30): Leslie Speed (OFF/SLOW/FAST via zones)
Encoder 2 (CC31): Vibrato/Chorus Type
Encoder 3 (CC32): Percussion On/Off
Encoder 4 (CC33): Overdrive Amount
Encoder 5 (CC34): Reverb Mix
Encoder 6 (CC35): Reverb Room
Encoder 7 (CC36): Master Tune
Encoder 8 (CC37): Spare / Effects Depth

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BUTTONS (Tertiary - Presets & Control):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Button Group 1 (CC50): Previous Preset (Hammond presets 1-36)
Button Group 2 (CC51): Next Preset
Button Group 3 (CC52): Leslie Bypass Toggle
Button Group 4 (CC53): Percussion Toggle
Button Group 5 (CC54): Vibrato On/Off
Button Group 6-10:     Direct preset selection (21-25)
Button Group 11-15:    Direct preset selection (26-30)
Button Group 16+:      Direct preset selection (31-36)
```

### Installation in Reaper

**Step 1: Configure SMC-Mixer**
```bash
# In SMC-Mixer DAW Mode or CC Mode, set:
Fader 1 → CC#7 (Vol)
Fader 2 → CC#10 (Pan)
Fader 3 → CC#12 (Ctrl1)
Fader 4 → CC#13 (Ctrl2)
Fader 5 → CC#14 (Ctrl3)
Fader 6 → CC#15 (Ctrl4)
Fader 7 → CC#16 (Ctrl5)
Fader 8 → CC#17 (Ctrl6)
```

**Step 2: Organ Configuration**
In Organ (OrganSingle.jsfx):
```javascript
// At top of @init:
keyboard_id = 5;  // M-Wave SMC-Mixer profile

// In @slider or @block:
function setup_smc_drawbars() (
  drawbar_cc[0] = 7;   // 16'
  drawbar_cc[1] = 10;  // 5⅓'
  drawbar_cc[2] = 12;  // 8'
  drawbar_cc[3] = 13;  // 4'
  drawbar_cc[4] = 14;  // 2⅔'
  drawbar_cc[5] = 15;  // 2'
  drawbar_cc[6] = 16;  // 1⅗'
  drawbar_cc[7] = 17;  // 1⅓'
  
  leslie_cc = 30;      // Leslie speed
  vibrato_cc = 31;     // Vibrato type
);
```

---

## 2️⃣ M-AUDIO AXIOM 61 → ORGAN (Hammond Drawbars + Keyboard)

**Primary Purpose:** Full keyboard playing + complete drawbar control

### Hardware Setup
- **61 Semi-weighted keys:** Play organ melodies/bass
- **9 Faders:** 9 drawbars (perfect 1:1 mapping!)
- **8 Knobs:** Effects control
- **8 Pads:** Drum triggers or preset switching
- **Expression/Sustain Pedals:** Dynamics

### MIDI CC Mapping

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
KEYBOARD (C1-C6, 61 Keys):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

All keys: Note on/off → Organ note input
Mod Wheel (CC1): Vibrato amount
Aftertouch: Dynamics/pressure sensitivity

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FADERS (Primary - All 9 Drawbars):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Fader 1 (CC7):    16' foot drawbar
Fader 2 (CC12):   5⅓' foot drawbar
Fader 3 (CC18):   8' foot drawbar
Fader 4 (CC19):   4' foot drawbar
Fader 5 (CC20):   2⅔' foot drawbar
Fader 6 (CC21):   2' foot drawbar
Fader 7 (CC22):   1⅗' foot drawbar
Fader 8 (CC23):   1⅓' foot drawbar
Fader 9 (CC26):   1' foot drawbar (master fader)

IMPORTANT: Use Axiom's 9-fader setup for complete Hammond control!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROTARY ENCODERS/KNOBS (8):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Knob 1 (CC74): Leslie Speed Control
Knob 2 (CC73): Vibrato/Chorus Type
Knob 3 (CC71): Percussion On/Off
Knob 4 (CC5):  Overdrive Amount
Knob 5 (CC10): Reverb Mix
Knob 6 (CC11): Reverb Room Size
Knob 7 (CC2):  Portamento Time
Knob 8 (CC3):  Master Tune

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
8 PADS (Velocity-sensitive):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Pad 1-4: Preset Quick Select
  Pad 1: Preset 21 (Rick Wakeman)
  Pad 2: Preset 25 (Tony Banks)
  Pad 3: Preset 29 (Keith Emerson)
  Pad 4: Preset 33 (John Lord)

Pad 5-6: Prev/Next Preset
Pad 7-8: Effects Toggle (Leslie/Vibrato)

ALTERNATIVE: Map pads to Drums instrument instead!
  Pads send Note On → Drum triggers
  (See Drum Pad section below)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SUSTAIN PEDAL (CC64):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sustain Pedal: Holds organ notes (CC64)
Expression Pedal: Dynamics control (CC11)
```

### Installation in Reaper

**Step 1: Configure Axiom 61**
```bash
# Map faders to drawbar CCs:
Fader 1 → CC#7
Fader 2 → CC#12
Fader 3 → CC#18
Fader 4 → CC#19
Fader 5 → CC#20
Fader 6 → CC#21
Fader 7 → CC#22
Fader 8 → CC#23
Fader 9 → CC#26

# Map knobs to effects:
Knob 1 → CC#74 (Leslie)
Knob 2 → CC#73 (Vibrato)
Knob 3 → CC#71 (Perc)
Knob 4 → CC#5 (Overdrive)
```

**Step 2: Organ Configuration**
```javascript
// At top of @init:
keyboard_id = 4;  // M-Audio Axiom 61 profile

// Setup function:
function setup_axiom_drawbars() (
  drawbar_cc[0] = 7;   // 16' (Fader 1)
  drawbar_cc[1] = 12;  // 5⅓' (Fader 2)
  drawbar_cc[2] = 18;  // 8' (Fader 3)
  drawbar_cc[3] = 19;  // 4' (Fader 4)
  drawbar_cc[4] = 20;  // 2⅔' (Fader 5)
  drawbar_cc[5] = 21;  // 2' (Fader 6)
  drawbar_cc[6] = 22;  // 1⅗' (Fader 7)
  drawbar_cc[7] = 23;  // 1⅓' (Fader 8)
  drawbar_cc[8] = 26;  // 1' (Fader 9)
);
```

---

## 3️⃣ M-AUDIO OXYGEN PRO MINI → ORGAN (Hammond Drawbars)

**Primary Purpose:** Portable keyboard + drawbar control via sliders

### Hardware Setup
- **32 Mini Keys:** Melodic input
- **9 Faders:** Drawbars (Fader 1=master, Faders 2-9=drawbars)
- **4 Knobs:** Effects control
- **Mod Wheel:** Leslie speed

### MIDI CC Mapping

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
KEYBOARD (C0-B2, 32 Mini Keys):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

All keys: Note input (use octave buttons for full range)
Mod Wheel (CC1): Leslie Speed (0-33=OFF, 34-67=SLOW, 68-127=FAST)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FADERS (Drawbars):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Fader 1 (CC7):    Master Volume (all drawbars)
Fader 2 (CC20):   16' foot drawbar
Fader 3 (CC21):   5⅓' foot drawbar
Fader 4 (CC22):   8' foot drawbar
Fader 5 (CC23):   4' foot drawbar
Fader 6 (CC24):   2⅔' foot drawbar
Fader 7 (CC25):   2' foot drawbar
Fader 8 (CC26):   1⅗' foot drawbar
Fader 9 (CC27):   1⅓' foot drawbar

NOTE: 9th drawbar (1') can be added to optional 10th fader
      Or controlled via knob

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROUND KNOBS (4):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Knob 1 (CC74): Vibrato/Chorus Type
Knob 2 (CC73): Percussion On/Off
Knob 3 (CC71): Overdrive Amount
Knob 4 (CC5):  Reverb Mix

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SPECIAL BUTTONS:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Prev Preset (CC50): Previous Hammond preset
Next Preset (CC51): Next Hammond preset
Octave +/-:         Transpose keyboard range
```

### Installation in Reaper

Already default! Oxygen Pro Mini is the standard profile for all instruments.

```javascript
// In Organ @init:
keyboard_id = 0;  // M-Audio Oxygen Pro Mini (DEFAULT)
```

---

## 🥁 4️⃣ DRUM PADS → DRUMS INSTRUMENT

**Purpose:** Control Drums instrument with velocity-sensitive pads

### Supported Pad Controllers
1. **Roland GO:KEYS 3** - 16 Pads
2. **Korg Nano Kontroller 2** - 16 Pads
3. **M-Audio Axiom 61** - 8 Pads

### Standard MIDI Drum Mapping (GM Compatible)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DRUM KIT STANDARD MIDI NOTES (Channel 10 / Percussion):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Note 36 (C1):  Kick Drum / Bass Drum
Note 37 (C#1): Side Stick / Cross Stick
Note 38 (D1):  Snare Drum / Acoustic Snare
Note 39 (D#1): Hand Clap
Note 40 (E1):  Closed Hi-Hat / Tight Hat
Note 41 (F1):  Low Tom / Low Tomtom
Note 42 (F#1): Closed Hi-Hat Pedal / Foot Hi-Hat
Note 43 (G1):  High Tom / High Tomtom
Note 44 (G#1): Pedal Hi-Hat / Hi-Hat Control
Note 45 (A1):  Mid Tom / Mid Tomtom
Note 46 (A#1): Open Hi-Hat / Open Hat
Note 47 (B1):  Low-Mid Tom
Note 48 (C2):  High Mid Tom / Mid Tom
Note 49 (C#2): Crash Cymbal 1
Note 50 (D2):  High Tom / Hi Tom
Note 51 (D#2): Ride Cymbal 1
Note 52 (E2):  Chinese Cymbal
Note 53 (F2):  Ride Cymbal (Bell)
Note 54 (F#2): Tambourine
Note 55 (G2):  Splash Cymbal
Note 56 (G#2): Cowbell
Note 57 (A2):  Crash Cymbal 2 / Crash
Note 58 (A#2): Vibraslap
Note 59 (B2):  Ride Cymbal 2
Note 60 (C3):  Hi Bongo
Note 61 (C#3): Low Bongo
Note 62 (D3):  Mute Hi Conga
Note 63 (D#3): Open Hi Conga / Hi Conga
Note 64 (E3):  Low Conga
Note 65 (F3):  High Timbale
Note 66 (F#3): Low Timbale
Note 67 (G3):  High Agogo
Note 68 (G#3): Low Agogo
Note 69 (A3):  Cabasa
Note 70 (A#3): Maracas
Note 71 (B3):  Short Whistle
Note 72 (C4):  Long Whistle
Note 73 (C#4): Short Guiro
Note 74 (D4):  Long Guiro
Note 75 (D#4): Claves
Note 76 (E4):  Hi Wood Block
Note 77 (F4):  Low Wood Block
Note 78 (F#4): Mute Cuica
Note 79 (G4):  Open Cuica
Note 80 (G#4): Mute Triangle
Note 81 (A4):  Open Triangle
Note 82 (A#4): Shaker
Note 83 (B4):  Jingle Bells
Note 84 (C5):  Belltree
Note 85 (C#5): Castanets
Note 86 (D5):  Mute Surdo
Note 87 (D#5): Open Surdo
```

### Mapping for Each Controller

#### **Roland GO:KEYS 3 (16 Pads)**

```
PAD LAYOUT (4x4 Grid):

Pad 1  Pad 2  Pad 3  Pad 4
Pad 5  Pad 6  Pad 7  Pad 8
Pad 9  Pad 10 Pad 11 Pad 12
Pad 13 Pad 14 Pad 15 Pad 16

DRUM MAPPING:

Pad 1:  Note 36 (Kick)
Pad 2:  Note 38 (Snare)
Pad 3:  Note 40 (Hi-Hat Closed)
Pad 4:  Note 46 (Hi-Hat Open)

Pad 5:  Note 41 (Low Tom)
Pad 6:  Note 43 (High Tom)
Pad 7:  Note 45 (Mid Tom)
Pad 8:  Note 49 (Crash 1)

Pad 9:  Note 51 (Ride Cymbal)
Pad 10: Note 56 (Cowbell)
Pad 11: Note 54 (Tambourine)
Pad 12: Note 69 (Cabasa)

Pad 13: Note 70 (Maracas)
Pad 14: Note 71 (Whistle)
Pad 15: Note 73 (Guiro)
Pad 16: Note 75 (Claves)
```

#### **Korg Nano Kontroller 2 (16 Pads)**

```
Same layout as GO:KEYS 3

Pads on Nano K2 send MIDI Note On/Off via USB
Default channel: 10 (Percussion)
Velocity: Based on pad pressure (velocity-sensitive)
```

#### **M-Audio Axiom 61 (8 Pads)**

```
PAD LAYOUT (8 Pads):

Pad 1  Pad 2  Pad 3  Pad 4
Pad 5  Pad 6  Pad 7  Pad 8

DRUM MAPPING (Essential 8):

Pad 1: Note 36 (Kick)
Pad 2: Note 38 (Snare)
Pad 3: Note 40 (Hi-Hat Closed)
Pad 4: Note 46 (Hi-Hat Open)
Pad 5: Note 41 (Low Tom)
Pad 6: Note 45 (Mid Tom)
Pad 7: Note 49 (Crash)
Pad 8: Note 51 (Ride)
```

### Installation in Reaper

**Step 1: Set Drums Track to MIDI Channel 10**
```
In Reaper:
  Track → MIDI Input → Channel 10 (Percussion)
```

**Step 2: Configure Drum Pad Controller**

For **Roland GO:KEYS 3**:
```
Menu → MIDI Ch → 10 (Percussion)
Pads already send correct Note numbers
```

For **Korg Nano Kontroller 2**:
```
Pads automatically send Note On/Off
Verify MIDI channel is set to 10 in Reaper preferences
```

For **M-Audio Axiom 61**:
```
Pad 1-8 → Configure to send Notes 36, 38, 40, 46, 41, 45, 49, 51
Via Axiom Editor or pad remapping
```

**Step 3: Drums Instrument Configuration**
```javascript
// In Drums.jsfx @init:
// Auto-detect pad controller and set channel 10 mode
midi_channel = 10;  // Percussion channel

// Map incoming MIDI notes to drum sounds
function setup_drum_pads() (
  drum_note[0] = 36;  // Kick
  drum_note[1] = 38;  // Snare
  drum_note[2] = 40;  // Hi-Hat closed
  drum_note[3] = 46;  // Hi-Hat open
  drum_note[4] = 41;  // Low Tom
  drum_note[5] = 45;  // Mid Tom
  drum_note[6] = 49;  // Crash
  drum_note[7] = 51;  // Ride
);
```

---

## 🎼 Setup Workflow

### **Configuration 1: Full Hammond Desk**
```
1. Connect: M-Audio Axiom 61
2. Enable: MIDI Channel 1
3. Load: Organ (OrganSingle.jsfx)
4. Play: 61 keys + 9 faders for drawbars
5. Use: All knobs for effects
6. Result: Professional Hammond controller
```

### **Configuration 2: Drawbar-Only Controller**
```
1. Connect: M-Wave SMC-Mixer
2. Enable: MIDI Channel 1
3. Load: Organ (OrganSingle.jsfx)
4. Use: 8 faders = 8 drawbars
5. Use: 8 encoders = effects
6. Use: Buttons = presets
7. Result: Dedicated drawbar workstation
```

### **Configuration 3: Portable Hammond**
```
1. Connect: M-Audio Oxygen Pro Mini
2. Enable: MIDI Channel 1
3. Load: Organ (OrganSingle.jsfx)
4. Play: 32 mini keys
5. Use: 9 faders = 9 drawbars (Fader 1=master)
6. Use: Mod wheel for Leslie speed
7. Result: Portable Hammond control
```

### **Configuration 4: Drum Programming**
```
1. Connect: Any pad controller (GO:3, Nano K2, or Axiom 61)
2. Set: MIDI Channel 10 (Percussion)
3. Load: Drums instrument
4. Use: Pads to trigger drum sounds
5. Record: Drum patterns via MIDI
6. Result: Velocity-sensitive drum control
```

---

## 🔧 Automation Script

Create a Reaper Lua script to quickly switch between configurations:

```lua
-- CONFIGURE_CONTROLLER.lua
local configs = {
  {name="Hammond Full Control",  device="Axiom 61",   track="Organ", channel=1},
  {name="Drawbar Workstation",   device="SMC-Mixer",  track="Organ", channel=1},
  {name="Portable Hammond",      device="Oxygen Mini", track="Organ", channel=1},
  {name="Drum Programming",      device="Any Pads",   track="Drums", channel=10}
}

function setup_config(config_id)
  local cfg = configs[config_id]
  reaper.ShowConsoleMsg("Setting up: " .. cfg.name .. "\n")
  reaper.ShowConsoleMsg("Device: " .. cfg.device .. "\n")
  reaper.ShowConsoleMsg("Track: " .. cfg.track .. "\n")
  reaper.ShowConsoleMsg("MIDI Channel: " .. cfg.channel .. "\n")
end

-- Display menu for user to select configuration
gfx.init("Controller Setup", 400, 300)
-- Draw buttons for each config...
```

---

## 📋 Quick Reference

| Task | Device | Setting | Result |
|------|--------|---------|--------|
| **Full Hammond playing** | Axiom 61 | 61 keys + 9 faders | Professional control |
| **Drawbar control only** | SMC-Mixer | 8 faders + encoders | Dedicated interface |
| **Portable Hammond** | Oxygen Mini | 32 keys + 9 faders | Mobile setup |
| **Drum programming** | Pad controller | MIDI Ch. 10 | Velocity-sensitive drums |

---

## ✅ Installation Checklist

- [ ] Configure M-Wave SMC drawbar CCs (CC7-CC17)
- [ ] Configure M-Audio Axiom 61 drawbar CCs (CC7, CC12-26)
- [ ] Keep Oxygen Pro Mini as default (already set)
- [ ] Set pad controllers to MIDI Channel 10
- [ ] Update Drums instrument to receive Channel 10
- [ ] Update Organ instrument to support multiple device profiles
- [ ] Create Reaper control surface configuration
- [ ] Test each configuration with actual devices

---

**All devices configured and ready to control your Reaper instruments!** 🎼
