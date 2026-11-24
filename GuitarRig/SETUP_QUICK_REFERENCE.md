# Guitar Legends - Quick Setup Reference

**Copy these settings into Guitar Station S2 for each legendary tone.**

---

## 1️⃣ GILMOUR (Shine, Money, Comfortably Numb)
```
Bass: 6.5  |  Mid: 5.5  |  Treble: 7.5  |  Bright: ON
Pre-Gain: 7.5  |  Distortion: 2.5  |  Master: 8

Amp: British Warm | Cabinet: British 1x12 (Closed)
Mic: Ribbon Mid | Gate: OFF
Distortion: Soft Clip | Chorus: 50% 1Hz | Delay: 375ms | Reverb: Spring 55%
```

---

## 2️⃣ THE BEATLES (Jangly Bright Clean)
```
Bass: 4.5  |  Mid: 6.5  |  Treble: 8.5  |  Bright: ON
Pre-Gain: 4.5  |  Distortion: 0.5  |  Master: 9

Amp: British Clean (Vox) | Cabinet: British 1x12 (Open)
Mic: SM57 Mid | Compressor: 4:1 Ratio
Distortion: OFF | Modulation: Chorus 25% 0.5Hz | Delay: OFF | Reverb: Spring 25%
```

---

## 3️⃣ HENDRIX (Heavy Fuzz & Sustain)
```
Bass: 7.5  |  Mid: 4.5  |  Treble: 6.5  |  Bright: OFF
Pre-Gain: 8.5  |  Distortion: 7  |  Master: 7

Amp: British Warm (Saturated) | Cabinet: British 2x12 (Closed)
Mic: SM57 Near | Gate: OFF
Distortion: Fuzz Heavy | Chorus: 60% 1.8Hz | Delay: 500ms | Reverb: Plate 65%
```

---

## 4️⃣ DEEP PURPLE (Thick Overdrive)
```
Bass: 7.5  |  Mid: 6.5  |  Treble: 5.5  |  Bright: OFF
Pre-Gain: 8.5  |  Distortion: 6  |  Master: 8

Amp: British Warm (100W) | Cabinet: British 4x12 (Closed)
Mic: SM57 Mid | Gate: Threshold -15dB
Distortion: Medium Sustain | Chorus: 30% 0.7Hz | Delay: 375ms | Reverb: Spring 45%
```

---

## 5️⃣ IRON MAIDEN (Bright Metal Crunch)
```
Bass: 6.5  |  Mid: 6.5  |  Treble: 7.5  |  Bright: ON
Pre-Gain: 7.5  |  Distortion: 8  |  Master: 7.5

Amp: Crunch (High-Gain) | Cabinet: British 2x12 (Closed)
Mic: SM57 Near | Gate: Threshold -10dB
Distortion: Heavy Tight | Flanger: 25% 0.8Hz | Delay: 375ms | Reverb: Plate 30%
```

---

## 6️⃣ NIRVANA (Grunge Wall of Sound)
```
Bass: 8.5  |  Mid: 4.5  |  Treble: 5.5  |  Bright: OFF
Pre-Gain: 9  |  Distortion: 8.5  |  Master: 7

Amp: Crunch (High-Gain) | Cabinet: British 4x12 (Closed)
Mic: SM57 Near | Compressor: 8:1 Ratio Mid Threshold | Gate: -15dB
Distortion: Massive Fuzz | Chorus: 50% 0.6Hz | Delay: OFF | Reverb: Spring 35%
```

---

## Saving Presets in Reaper

### Method 1: Within Guitar Station S2 UI
1. Configure all settings above
2. Click **Preset** button in plugin UI
3. Click **Save** (bottom left)
4. Type preset name: `Gilmour Shine`
5. Presets save to: `~/.config/REAPER/Effects/Tukan/Guitar Station S2 (Tukan).RPL`

### Method 2: Save FX Preset (Reaper)
1. Configure Guitar Station S2 plugin
2. Right-click plugin name → **"Save FX Preset"**
3. Name: `GuitarRig - Gilmour`
4. Location: `REAPER/FXPresets/`

### Method 3: Save FX Chain (Track Template)
1. Configure Guitar Station S2 on a guitar track
2. If using Guitar instrument: **FX → Save chain as...**
3. Name: `Guitar - Gilmour.RfxChain`
4. Save to: `REAPER/FXChains/`
5. Future tracks: **FX → Chain → Guitar - Gilmour**

---

## A/B Comparison Tips

Create two adjacent guitar tracks:
- Track 1: Gilmour tone
- Track 2: Hendrix tone

Solo/un-solo each to compare settings and understand the parameter ranges.

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| **Distortion sounds muddy** | ↓ Bass, increase Treble/Bright |
| **Too thin/scratchy** | ↑ Bass, ↑ Mid range |
| **Lacks sustain** | ↑ Distortion, ↑ Pre-Gain |
| **Too compressed** | Lower Compressor ratio or threshold |
| **Delay/Reverb overpowering** | Lower mix percentages (try 30-40%) |
| **Noise/hum** | ↑ Gate threshold, reduce Distortion |
| **Can't hear modulation** | ↑ Depth/Rate on Chorus/Flanger |

---

## Next Steps

1. **Start with Gilmour** - Most forgiving, teaches tone shaping
2. **Then Beatles** - Learn clean tone contrast
3. **Then Hendrix** - Heavy distortion mastery
4. **Then remaining** - Experiment and refine

Good luck! 🎸✨
