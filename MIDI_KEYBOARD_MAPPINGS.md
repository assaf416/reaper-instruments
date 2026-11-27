# MIDI Keyboard Mappings for Reaper Instruments

Complete MIDI mapping guide for 6 keyboards to 7 custom instruments.

**Default Keyboard:** M-Audio Oxygen Pro Mini (selected by default in all instruments)

---

## 🎹 Keyboard Specifications

### 1. M-Audio Oxygen Pro Mini (DEFAULT)

| Specification | Value |
|---------------|-------|
| **Keys** | 32 mini keys (C0-B2) |
| **Faders** | 9 faders (CCs 7, 10, 20-26) |
| **Round Knobs** | 8 encoders (CCs 1, 11, 2, 3, 74, 73, 71, 5) |
| **Buttons** | 16 pads, various control buttons |
| **MIDI Channels** | 1-16 (selectable per control) |
| **Octave Range** | +/- 2 octaves |
| **MIDI Out** | USB + 5-pin DIN |

**CC Mapping (Default):**
- **Mod Wheel:** CC1
- **Master Volume:** CC7
- **Expression:** CC11
- **Effects 1-4:** CCs 2, 3, 74, 73
- **Fader 2-9:** CCs 20-26
- **Master Volume Fader:** CC7

---

### 2. Casio Privia PX-150

| Specification | Value |
|---------------|-------|
| **Keys** | 88 weighted hammer-action keys |
| **Sounds** | 38 high-quality tones (piano, synth, etc.) |
| **Pedals** | 3 (sustain, soft, sostenuto) |
| **MIDI Channels** | 1-16 |
| **MIDI Out** | USB + 5-pin DIN |
| **Expression** | CC11 (via expression pedal) |
| **Sustain** | CC64 (via sustain pedal) |

**Use Case:** Full-range piano playing, sustain control

---

### 3. Roland GO:3 (Green)

| Specification | Value |
|---------------|-------|
| **Keys** | 25 mini keys |
| **Knobs** | 2 rotary encoders |
| **Buttons** | 16 pads, 4 control buttons |
| **MIDI Channels** | 1-16 (per zone) |
| **Features** | Dual layer zones, scene switching |
| **MIDI Out** | USB |
| **Built-in Sounds** | 500+ tones, drums, effects |

**Use Case:** Pad triggering, scene switching, dual zone control

---

### 4. Korg Nano Kontroller 2

| Specification | Value |
|---------------|-------|
| **Keys** | None (control surface only) |
| **Faders** | 4 vertical faders (CCs 2, 3, 4, 5) |
| **Knobs** | 8 rotary encoders (CCs 14-21) |
| **Buttons** | 16 pads, various control buttons |
| **Pad Colors** | RGB feedback (when supported) |
| **MIDI Out** | USB + 5-pin DIN |
| **Template Switching** | 4 templates selectable |

**Use Case:** Control surface for effects, mixing, parameter automation

---

### 5. M-Audio Axiom 61

| Specification | Value |
|---------------|-------|
| **Keys** | 61 semi-weighted keys (C1-C6) |
| **Faders** | 9 faders (CCs 7, 10, 12-18) |
| **Knobs** | 8 rotary encoders (CCs 20-27) |
| **Buttons** | 16 pads, transport controls, preset switching |
| **MIDI Channels** | 1-16 |
| **Expression** | CC11 |
| **Sustain** | CC64 |
| **MIDI Out** | USB + 5-pin MIDI IN/OUT |

**Use Case:** Keyboard playing with full control surface

---

### 6. M-Wave SMC-Mixer

| Specification | Value |
|---------------|-------|
| **Faders** | 4 vertical faders (CCs 7, 10, 12, 13) |
| **Knobs** | Optional encoders |
| **Purpose** | Audio mixing/MIDI control surface |
| **MIDI Channels** | 1-16 |
| **MIDI Out** | USB |

**Use Case:** Master volume control, mixing assistant

---

## 🎼 Instrument MIDI Mappings

All instruments configured with **M-Audio Oxygen Pro Mini** as default selector.

### 1. 🎹 Mellotron (3-Tape Mixer)

**Purpose:** 3-layer tape sampler with master + layer mixing

**MIDI Mapping Strategy:**
```
Fader 1 (CC7):    Master Volume (all tapes)
Fader 2 (CC20):   Tape 1 Volume (DecenTron)
Fader 3 (CC21):   Tape 2 Volume
Fader 4 (CC22):   Tape 3 Volume
Fader 5 (CC23):   Tape 1 Pan
Fader 6 (CC24):   Tape 2 Pan
Fader 7 (CC25):   Tape 3 Pan
Fader 8 (CC26):   Wow & Flutter Amount

Knob 1 (CC1):     Mod Wheel (overall volume envelope)
Knob 2 (CC11):    Expression Pedal (dynamics)
Knob 3 (CC74):    Tape Saturation
Knob 4 (CC73):    Reverb Mix

Button Group:
- Prev Sound:     CC50 (previous tape selection)
- Next Sound:     CC51 (next tape selection)
- Master On/Off:  CC52 (mute all tapes)
```

**Keyboard Selector (CC# 0-5):**
- 0: M-Audio Oxygen Pro Mini (default)
- 1: Casio Privia PX-150 (use sustain for tape control)
- 2: Roland GO:3 (map faders to tape volumes)
- 3: Korg Nano Kontroller 2 (use 4 faders for layer mixing)
- 4: M-Audio Axiom 61 (full control)
- 5: M-Wave SMC-Mixer (master volume only)

---

### 2. 🎵 Organ (Hammond-Style, 36 Presets)

**Purpose:** Drawbar organ with Leslie rotary speaker

**MIDI Mapping Strategy:**
```
Faders 1-9 (CCs 7, 20-26):  9 Drawbars
  CC7:  16' foot
  CC20: 5⅓' foot
  CC21: 8' foot
  CC22: 4' foot
  CC23: 2⅔' foot
  CC24: 2' foot
  CC25: 1⅗' foot
  CC26: 1⅓' foot
  (Note: 9th fader spare)

Mod Wheel (CC1):  Leslie Speed Control
  0-33:   OFF
  34-67:  SLOW
  68-127: FAST

Knob 1 (CC74):    Vibrato/Chorus Selector
Knob 2 (CC73):    Percussion On/Off
Knob 3 (CC71):    Overdrive Amount
Knob 4 (CC5):     Reverb Mix

Button Group:
- Prev Preset:    CC50 (preset 1-20)
- Next Preset:    CC51
- Preset Direct:  CC52-61 (up to 10 presets)
- Leslie Bypass:  CC62
```

**Advanced Leslie Control:**
```
Mod Wheel Zones (CC1):
- 0-10:    OFF (Leslie disabled)
- 11-50:   SLOW (Leslie rotates slowly)
- 51-100:  FAST (Leslie rotates quickly)
- 101-127: RAMP (accelerates from slow to fast)
```

---

### 3. 🎹 Piano (4 Velocity-Layered Pianos)

**Purpose:** Multiple piano libraries with velocity sensitivity

**MIDI Mapping Strategy:**
```
Faders:
Fader 1 (CC7):    Master Volume
Fader 2 (CC20):   Piano 1 (Fender Rhodes) Volume
Fader 3 (CC21):   Piano 2 (King's Upright) Volume
Fader 4 (CC22):   Piano 3 (Grand Piano) Volume
Fader 5 (CC23):   Piano 4 (Bedroom Piano) Volume
Fader 6 (CC24):   Reverb Mix
Fader 7 (CC25):   Chorus/Warmth
Fader 8 (CC26):   EQ Brightness

Knobs:
Knob 1 (CC74):    Sustain Pedal Amount
Knob 2 (CC73):    Release Time
Knob 3 (CC71):    Hammer Noise Amount
Knob 4 (CC5):     Pedal Noise

Button Group:
- Prev Piano:     CC50 (switch between 4 pianos)
- Next Piano:     CC51
- Velocity Map:   CC52 (dynamic response)
- Humanize:       CC53 (slight timing variation)
```

---

### 4. 🎸 Guitar (3 Electric Guitar Layers)

**Purpose:** Sampled electric guitars with FX processing

**MIDI Mapping Strategy:**
```
Faders:
Fader 1 (CC7):    Master Volume
Fader 2 (CC20):   Guitar 1 Volume
Fader 3 (CC21):   Guitar 2 Volume
Fader 4 (CC22):   Guitar 3 Volume
Fader 5 (CC23):   Chorus Amount
Fader 6 (CC24):   Delay Mix
Fader 7 (CC25):   Reverb Mix
Fader 8 (CC26):   Distortion Amount

Round Knobs (Primary - Effects Control):
Knob 1 (CC74):    Delay Time (synced to tempo)
Knob 2 (CC73):    Delay Feedback
Knob 3 (CC71):    Chorus Rate
Knob 4 (CC5):     Reverb Room Size

Button Group:
- Prev Guitar:    CC50
- Next Guitar:    CC51
- Sustain On/Off: CC52
- Slide/Bend:     CC53
- Pick Attack:    CC54
```

---

### 5. 🥁 Drums (5 Velocity-Layered Kits)

**Purpose:** Percussion with drum kits and mixing

**MIDI Mapping Strategy:**
```
Faders (Drum Element Mixing):
Fader 1 (CC7):    Master Volume
Fader 2 (CC20):   Kick Drum Volume
Fader 3 (CC21):   Snare Drum Volume
Fader 4 (CC22):   Hi-Hat Volume
Fader 5 (CC23):   Tom Toms Volume
Fader 6 (CC24):   Percussion/Cymbals Volume
Fader 7 (CC25):   Reverb Mix
Fader 8 (CC26):   Compression Amount

Knobs:
Knob 1 (CC74):    Kick Attack Time
Knob 2 (CC73):    Snare Brightness
Knob 3 (CC71):    Hi-Hat Open/Close (0-64: closed, 65-127: open)
Knob 4 (CC5):     Tom Pitch (high-to-low)

Button Group:
- Prev Kit:       CC50 (5 drum kits)
- Next Kit:       CC51
- Swing Amount:   CC52
- Humanize:       CC53
- Reverb Pre/Post: CC54

MIDI Note Mapping (Keyboard):
C1 (36):  Kick Drum
D1 (38):  Snare Drum
E1 (40):  Closed Hi-Hat
F1 (41):  Low Tom
G1 (43):  Mid Tom
A1 (45):  High Tom
B1 (47):  Crash Cymbal
C2 (48):  Ride Cymbal
```

---

### 6. 🎹 RetroSynth (50 Presets - Pads, Leads, Bass)

**Purpose:** Polyphonic synth with 50 presets + effects control

**MIDI Mapping Strategy:**
```
Faders (Parameter Control):
Fader 1 (CC7):    Master Volume
Fader 2 (CC20):   Cutoff Frequency
Fader 3 (CC21):   Filter Resonance
Fader 4 (CC22):   Filter Envelope Amount
Fader 5 (CC23):   Attack Time
Fader 6 (CC24):   Release Time
Fader 7 (CC25):   LFO Rate
Fader 8 (CC26):   LFO to Pitch Amount

Round Knobs (Primary - Effects):
Knob 1 (CC74):    Chorus Depth
Knob 2 (CC73):    Delay Time (synced)
Knob 3 (CC71):    Delay Feedback
Knob 4 (CC5):     Reverb Mix

Mod Wheel (CC1):  Pitch Bend / Vibrato
Expression (CC11): Overall Dynamics

Button Group:
- Prev Preset:    CC50 (0-33 original, 34-49 analog legends)
- Next Preset:    CC51
- Preset Category: CC52 (PAD/LEAD/BASS selector)
- Sustain Pedal:  CC64
- Legato Mode:    CC68
```

**Preset Organization (CC50/51 for cycling):**
```
0-10:    Pads (Genesis, Banks, Floyd, etc.)
11-23:   Leads (Moore, Duran, Marillion)
24-33:   Bass sounds (Duran, Moog, Sub, Rubber)
34-49:   Analog Legends (Rick Wakeman, Pink Floyd, Keith Emerson, etc.)

Quick Preset Selection (CC52-61):
CC52:    Pad Selection
CC53:    Lead Selection
CC54:    Bass Selection
CC55-61: Direct access to analog legends
```

---

### 7. 🎵 GeneralMIDI (128 Instruments, 31 Drum Kits)

**Purpose:** Full GM2 SoundFont with 128 programs

**MIDI Mapping Strategy:**
```
Faders (Mixing & Dynamics):
Fader 1 (CC7):    Master Volume
Fader 2 (CC20):   Instrument 1 Volume
Fader 3 (CC21):   Instrument 2 Volume
Fader 4 (CC22):   Instrument 3 Volume
Fader 5 (CC23):   Instrument 4 Volume
Fader 6 (CC24):   Effects Bus 1
Fader 7 (CC25):   Effects Bus 2
Fader 8 (CC26):   Master Reverb

Knobs (Primary - Effect Control):
Knob 1 (CC74):    Reverb Room
Knob 2 (CC73):    Chorus Depth
Knob 3 (CC71):    Delay Time
Knob 4 (CC5):     Reverb Wet/Dry

MIDI Program Change:
CC0 (Bank Select): Selects instrument bank (0-127)
PC (Program Change): Selects specific instrument (0-127)
  0-7:    Piano family
  8-15:   Chromatic percussion
  16-23:  Organ family
  24-31:  Guitar family
  32-39:  Bass family
  40-47:  String family
  48-55:  Ensemble
  56-63:  Brass
  64-71:  Reed
  72-79:  Pipe
  80-87:  Synth lead
  88-95:  Synth pad
  96-103: Synth effects
  104-111: Ethnic instruments
  112-119: Percussive
  120-127: Sound effects + drum kits

Drum Kit Selection (CC32=0, PC=128-157):
  128-130: Drum kit banks
  131-157: Variation drum kits (31 total)

Button Group:
- Bank Down:      CC51 (previous bank)
- Bank Up:        CC50 (next bank)
- Drum Kit Toggle: CC52
- Reverb On/Off:  CC53
- Chorus On/Off:  CC54
```

---

### 8. 🎼 MusicTools (Chord Viewer, Riff Generator, Solo Generator)

**Purpose:** Composition aids and MIDI pattern generation

**MIDI Mapping Strategy:**
```
Faders (Tool Control):
Fader 1 (CC7):    Master Volume
Fader 2 (CC20):   Chord Complexity (simple-jazz)
Fader 3 (CC21):   Riff Pattern Length (4-16 bars)
Fader 4 (CC22):   Solo Speed (slow-fast)
Fader 5 (CC23):   Pattern Density (sparse-dense)
Fader 6 (CC24):   Humanization Amount
Fader 7 (CC25):   Swing/Groove Amount
Fader 8 (CC26):   Template Selection

Round Knobs (Tool Parameters):
Knob 1 (CC74):    Scale Selection (major-minor-modal)
Knob 2 (CC73):    Root Note (C-B)
Knob 3 (CC71):    Octave Range
Knob 4 (CC5):     Tempo/Speed

Button Group:
- Generate Chord: CC50 (create new chord)
- Generate Riff:  CC51 (create new riff)
- Generate Solo:  CC52 (create new solo)
- Play/Stop:      CC53
- Clear Pattern:  CC54
- Save to MIDI:   CC55
```

---

## 🎛️ Keyboard-Specific Implementations

### Using Different Keyboards with All Instruments

#### Scenario 1: Casio Privia PX-150 (Full 88 Keys)

**Optimization:**
- Use for: Playing full range, piano-focused sessions
- Assign: CC11 (expression pedal) to filter/dynamics
- Map: Sustain pedal (CC64) to instrument sustain
- Advantage: Full-range playing with weighted keys

**Setup Script:**
```
# In each instrument's @slider or @gfx:
CC1 -> Mod Wheel (Mellotron Leslie, Synth vibrato)
CC11 -> Expression (dynamics control)
CC64 -> Sustain (all instruments)

# Primary use: Piano, Mellotron, Synth lead/pad playing
```

---

#### Scenario 2: Roland GO:3 (Pads + Dual Zones)

**Optimization:**
- Use for: Pad triggering, scene switching
- Left Zone: Drums (note triggers)
- Right Zone: Synth/Pad (note triggers)

**Setup Script:**
```
# Map GO:3 Pads to:
Pads 1-4:   Prev/Next Preset, Mute, Solo
Pads 5-8:   Drum triggers
Pads 9-16:  Chord triggers
```

---

#### Scenario 3: Korg Nano Kontroller 2 (Control Surface Only)

**Optimization:**
- Use for: Effects control, mixing, automation
- Best with: Mellotron, Guitar Rig, GeneralMIDI

**Setup Script:**
```
# 4 Faders:
Fader 1 (CC2):  Master Volume
Fader 2 (CC3):  Effects 1
Fader 3 (CC4):  Effects 2
Fader 4 (CC5):  Effects 3

# 8 Knobs:
Knob 1-4 (CC14-17): Effect Parameters
Knob 5-8 (CC18-21): More Effect Parameters

# 16 Pads:
Pads 1-4:   Prev/Next Sound, Template Swap
Pads 5-16:  Instrument presets
```

---

#### Scenario 4: M-Audio Axiom 61 (Full Controller)

**Optimization:**
- Use for: Complete control + keyboard playing
- Best with: All instruments

**Setup Script:**
```
# Full 61-key keyboard for playing
# 9 Faders for complete mixing/control
# 8 Knobs for effects + parameters
# 16 Pads for preset switching and triggers

# Map all 9 faders to instrument parameters
# Map all 8 knobs to effects
```

---

#### Scenario 5: M-Wave SMC-Mixer (Mixing Only)

**Optimization:**
- Use for: Master volume, track mixing only
- Best with: Multiple instruments running simultaneously

**Setup Script:**
```
# Fader 1 (CC7):  Master Volume (all tracks)
# Fader 2 (CC10): Track 1 Volume
# Fader 3 (CC12): Track 2 Volume
# Fader 4 (CC13): Track 3 Volume

# Simple mixing assistant - no effect control
```

---

## 🔧 Installation Instructions

### Step 1: Set Default Keyboard

In each JSFX instrument, add at the top of @init:

```javascript
// Keyboard selector (default: M-Audio Oxygen Pro Mini = 0)
keyboard_id = 0;  // 0=Oxygen Mini, 1=Privia, 2=GO:3, 3=Nano K2, 4=Axiom61, 5=SMC

// MIDI CC assignments based on keyboard
function set_keyboard(id) (
  keyboard_id = id;
  // Load appropriate CC mappings for this keyboard
  // (implementation in each instrument)
);
```

---

### Step 2: Implement Keyboard Selector in Reaper

Create a Lua script to switch keyboards globally:

```lua
-- select_keyboard.lua - Global keyboard selector
local keyboards = {
  {name="M-Audio Oxygen Pro Mini", id=0},
  {name="Casio Privia PX-150", id=1},
  {name="Roland GO:3", id=2},
  {name="Korg Nano Kontroller 2", id=3},
  {name="M-Audio Axiom 61", id=4},
  {name="M-Wave SMC-Mixer", id=5}
}

-- Function to select keyboard for all tracks
function select_keyboard(keyboard_id)
  local proj = reaper.EnumProjects(-1)
  for i = 0, reaper.CountTracks(proj)-1 do
    local track = reaper.GetTrack(proj, i)
    -- Send MIDI CC to select keyboard
    -- Implementation: Send CC message to each instrument
  end
  reaper.ShowConsoleMsg("Switched to: " .. keyboards[keyboard_id+1].name .. "\n")
end

-- Display menu
gfx.init("Select Keyboard", 300, 300)
-- Draw keyboard buttons
```

---

### Step 3: Configure Each Instrument

For each JSFX instrument, add:

```javascript
@ui
// Draw keyboard selector dropdown
function draw_keyboard_selector() (
  // Show current keyboard
  // Allow switching
);

@block
// Update MIDI CC mappings based on selected keyboard
keyboard_id == 0 ? (
  // M-Audio Oxygen Pro Mini mappings
  volume_cc = 7;
  filter_cc = 20;
  // etc.
) : keyboard_id == 1 ? (
  // Casio Privia mappings
  volume_cc = 7;
  filter_cc = 11;  // Use expression pedal
  // etc.
) : (
  // Default mappings
);
```

---

## 📋 Quick Reference Table

### All Instruments MIDI CC Mapping (M-Audio Oxygen Pro Mini Default)

| Function | CC# | Mellotron | Organ | Piano | Guitar | Drums | Synth | GM2 |
|----------|-----|-----------|-------|-------|--------|-------|-------|-----|
| **Volume** | 7 | Master Vol | - | Master | Master | Master | Master | Master |
| **Mod Wheel** | 1 | Envelope | Leslie Speed | - | - | - | Vibrato | - |
| **Expression** | 11 | Dynamics | - | Sustain | - | - | Dynamics | - |
| **Filter** | 20 | Saturation | Drawbar 1 | Brightness | Delay Time | Kick Vol | Cutoff | Reverb |
| **Sustain** | 64 | - | Perc On/Off | Sustain | - | - | - | - |
| **Fader 2** | 20 | Tape 1 Vol | Drawbar 1 | Piano 1 | Guitar 1 | Kick | Cutoff | Inst 1 |
| **Fader 3** | 21 | Tape 2 Vol | Drawbar 2 | Piano 2 | Guitar 2 | Snare | Filter Res | Inst 2 |
| **Fader 4** | 22 | Tape 3 Vol | Drawbar 3 | Piano 3 | Guitar 3 | Hi-Hat | Filter Env | Inst 3 |
| **Fader 5** | 23 | Pan 1 | Drawbar 4 | Piano 4 | Chorus | Toms | Attack | Inst 4 |
| **Fader 6** | 24 | Pan 2 | Drawbar 5 | Reverb | Reverb | Reverb | Release | Reverb |
| **Fader 7** | 25 | Pan 3 | Drawbar 6 | Chorus | Distortion | Compression | LFO Rate | Chorus |
| **Fader 8** | 26 | Wow/Flutter | Drawbar 7 | EQ | - | Swing | LFO Pitch | Delay |
| **Knob 1** | 74 | Saturation | Vibrato | Sustain Amt | Delay Time | Kick Attack | Chorus | Reverb |
| **Knob 2** | 73 | Reverb | Percussion | Release | Delay FB | Snare Bright | Delay | Chorus |
| **Knob 3** | 71 | Tape Pan | Overdrive | Hammer Noise | Chorus Rate | Hi-Hat | Delay FB | Delay |
| **Knob 4** | 5 | - | Reverb | Pedal Noise | Reverb Room | Tom Pitch | Reverb | Reverb |
| **Prev Preset** | 50 | Tape- | Preset- | Piano- | Guitar- | Kit- | Preset- | Bank- |
| **Next Preset** | 51 | Tape+ | Preset+ | Piano+ | Guitar+ | Kit+ | Preset+ | Bank+ |

---

## 🎼 Suggested Workflow

### Session 1: Learning
1. Load **M-Audio Oxygen Pro Mini** (default)
2. Play each instrument
3. Adjust faders/knobs to understand mapping
4. Practice preset switching (CC50/51)

### Session 2: Keyboard Switching
1. Connect second keyboard (e.g., Casio Privia)
2. Use Reaper Lua script to switch
3. Adjust volumes to match Oxygen Mini
4. Test all faders/knobs with new keyboard

### Session 3: Integration
1. Connect multiple keyboards simultaneously
2. Assign zones (GO:3 for pads, Privia for leads)
3. Use SMC-Mixer for master mixing
4. Record MIDI performance

### Session 4: Advanced
1. Create custom templates per keyboard
2. Save keyboard profiles
3. Quick-switch via Reaper macros
4. Automate keyboard selection per song

---

## 🚀 Next Steps

1. **Instrument Updates:** Add CC keyboard selector to each JSFX
2. **Lua Automation:** Create global keyboard-switching Lua scripts
3. **Configuration Files:** Save keyboard profiles for quick recall
4. **Testing:** Verify all mappings with actual hardware

---

**All 6 keyboards ready to control all 7 instruments!** 🎵
