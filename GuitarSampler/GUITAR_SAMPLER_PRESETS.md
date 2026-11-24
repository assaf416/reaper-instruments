# Guitar Sampler - 10 Legendary Tone Presets

**Complete FX chain specifications for playing guitar samples through legendary guitar rigs.**

Each preset combines a sampled guitar source with the Tukan Studios Guitar Station S2 rig configured for a specific legendary guitarist's tone.

---

## Setup Template: Base Configuration

For all presets below:

1. **Audio Track Setup**
   - Create new audio track
   - Name: `Guitar - [Preset Name]`
   - Input: None (using samples, not audio input)

2. **ReaSampler Setup**
   - Add `ReaSampler` plugin as first effect
   - Load sample from: `Guitar/samples/Guitars/[Type]/Samples/`
   - Recommended base sample: `C4.wav` or root note of your sample type
   - Set to **Monophonic mode** for single-note playback
   - Master volume: 0dB

3. **Guitar Station S2 Setup**
   - Add `Guitar Station S2` after ReaSampler
   - Configure with settings below for each preset
   - Master output: -3dB to -6dB

---

## 1. GILMOUR - Warm Sustaining Lead (Shine, Money, Comfortably Numb)

**Sample Recommendation**: Clean Electric Guitar - C4.wav or E4.wav

```
ReaSampler Settings:
  Mode: Monophonic (plays one note at a time)
  Volume: 0dB
  Pitch Mode: Time-stretch (preserves sample length)

Guitar Station S2 Configuration:
  Bass: 6.5
  Mid: 5.5
  Treble: 7.5
  Bright: ON
  Pre-Gain: 7.5
  Distortion Level: 2.5
  
Amp Selection:
  Amp: British Warm
  Cabinet: British 1x12 (Closed back)
  Microphone: Ribbon (or SM57 Mid)
  
Effects Chain:
  Gate: OFF
  Distortion: Soft Clip (Pre-amp saturation)
  Modulation: CHORUS - 50% depth, 1Hz rate
  Delay: 375ms (dotted-eighth @ 120BPM)
  Reverb: Spring Reverb, 55% mix
  Master: 8/10
```

**Best Sample Types**:
- Clean Electric Guitar (bright, cutting)
- 12 String Acoustic (layered shimmer)

**Playing Tips**:
- Let samples ring and blend with reverb
- Use moderate mod wheel for vibrato
- Perfect for sustained melodic passages

---

## 2. THE BEATLES - Jangly Bright Clean

**Sample Recommendation**: 12 String Acoustic - C4.wav or higher notes

```
ReaSampler Settings:
  Mode: Monophonic
  Volume: 0dB
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 4.5
  Mid: 6.5
  Treble: 8.5
  Bright: ON
  Pre-Gain: 4.5
  Distortion Level: 0.5
  
Amp Selection:
  Amp: British Clean (Vox-style) or American Clean
  Cabinet: British 1x12 (Open back)
  Microphone: SM57 (Mid position)
  
Effects Chain:
  Gate: OFF
  Distortion: OFF or minimal
  Modulation: CHORUS - 25% depth, 0.5Hz rate
  Delay: OFF or minimal (250ms if used)
  Reverb: Spring Reverb, 25% mix
  Compressor: 4:1 ratio for sustain
  Master: 9/10
```

**Best Sample Types**:
- 12 String Acoustic (authentic jangle)
- Clean Electric Guitar (articulate)

**Playing Tips**:
- Emphasize pick attacks for brightness
- Play chords and arpeggios for jangly effect
- Fast attack, quick response

---

## 3. HENDRIX - Heavy Fuzz & Sustain

**Sample Recommendation**: Clean Electric Guitar - higher octaves for lead tone

```
ReaSampler Settings:
  Mode: Monophonic
  Volume: +2dB (boost for Hendrix aggression)
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 7.5
  Mid: 4.5
  Treble: 6.5
  Bright: OFF
  Pre-Gain: 8.5
  Distortion Level: 7
  
Amp Selection:
  Amp: British Warm (Saturated/Crunch)
  Cabinet: British 2x12 (Closed back)
  Microphone: SM57 (Near position)
  
Effects Chain:
  Gate: OFF (let sustain ring)
  Distortion: FUZZ-STYLE - Heavy sustain
  Modulation: CHORUS - 60% depth, 1.8Hz rate (trippy swirl)
  Delay: 500ms (quarter-note @ 120BPM)
  Reverb: Plate Reverb, 65% mix
  Master: 7/10
```

**Best Sample Types**:
- Clean Electric Guitar (transforms through distortion)
- Classic Electric (RJS) for vintage character

**Playing Tips**:
- Heavy vibrato on sustain
- Bend samples aggressively with pitch shift
- Use feedback-friendly high volumes
- Layer with another track for doubling effect

---

## 4. DEEP PURPLE - Thick Overdrive

**Sample Recommendation**: Clean Electric Guitar - mid-range notes

```
ReaSampler Settings:
  Mode: Monophonic
  Volume: +1dB
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 7.5
  Mid: 6.5
  Treble: 5.5
  Bright: OFF
  Pre-Gain: 8.5
  Distortion Level: 6
  
Amp Selection:
  Amp: British Warm (100W stack)
  Cabinet: British 4x12 (Closed back) - full, authoritative
  Microphone: SM57 (Mid position)
  
Effects Chain:
  Gate: Threshold -15dB (sustain control)
  Distortion: Medium Sustain (fat, creamy overdrive)
  Modulation: CHORUS - 30% depth, 0.7Hz rate
  Delay: 375ms (dotted-eighth @ 120BPM)
  Reverb: Spring/Plate Reverb, 45% mix
  Master: 8/10
```

**Best Sample Types**:
- Clean Electric Guitar (creates organ-like sustain)
- Classic Electric (vintage warmth)

**Playing Tips**:
- Slow vibrato (Deep Purple trademark)
- Let distortion bloom (delayed attack)
- Full sustain on lead notes
- Power chords sound massive

---

## 5. IRON MAIDEN - Bright Metal Crunch

**Sample Recommendation**: Clean Electric Guitar - higher notes for harmonic clarity

```
ReaSampler Settings:
  Mode: Monophonic
  Volume: 0dB
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 6.5
  Mid: 6.5
  Treble: 7.5
  Bright: ON (critical for harmonics)
  Pre-Gain: 7.5
  Distortion Level: 8.5
  
Amp Selection:
  Amp: Crunch (High-Gain British)
  Cabinet: British 2x12 (Closed back) - tight, present
  Microphone: SM57 (Near position)
  
Effects Chain:
  Gate: Threshold -10dB (palm-muting definition)
  Distortion: Heavy Tight Articulate
  Modulation: FLANGER - 25% depth, 0.8Hz rate (harmonic thickness)
  Delay: 375ms (dotted-eighth @ 120BPM)
  Reverb: Plate Reverb, 30% mix
  Master: 7.5/10
```

**Best Sample Types**:
- Clean Electric Guitar (high notes for harmonics)
- NLMDAGuitar (modern, articulate)

**Playing Tips**:
- Fast picking for percussive feel
- Harmonic divisions require clarity
- Sustain natural from distortion
- Palm-muting simulated with velocity control

---

## 6. NIRVANA - Grunge Wall of Sound

**Sample Recommendation**: Clean Electric Guitar - full range for heavy tone

```
ReaSampler Settings:
  Mode: Monophonic
  Volume: +2dB (maximum power)
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 8.5
  Mid: 4.5
  Treble: 5.5
  Bright: OFF (murky grunge character)
  Pre-Gain: 9
  Distortion Level: 8.5
  
Amp Selection:
  Amp: Crunch (High-Gain)
  Cabinet: British 4x12 (Closed, tight)
  Microphone: SM57 (Near position)
  
Effects Chain:
  Compressor: 8:1 ratio, mid threshold (heavy compression)
  Gate: Threshold -15dB (cut feedback between parts)
  Distortion: Massive Fuzz-like heaviness
  Modulation: CHORUS - 50% depth, 0.6Hz rate (slight thickness)
  Delay: 500ms (quarter-note) or OFF
  Reverb: Spring Reverb, 35% mix
  Master: 7/10
```

**Best Sample Types**:
- Clean Electric Guitar (transforms completely)
- Any electric sample (all sound heavy)

**Playing Tips**:
- Massive power chords, slight pick scrape
- Compression gives "squashed" feel
- Dramatic dynamic shifts (quiet → loud)
- Feedback-friendly setup

---

## 7. QUEEN - Brian May (Lush & Orchestral)

**Sample Recommendation**: 12 String Acoustic OR Clean Electric Guitar - warm tones

```
ReaSampler Settings:
  Mode: Polyphonic (for chords)
  Volume: 0dB
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 6.5
  Mid: 6.5
  Treble: 7.5
  Bright: ON
  Pre-Gain: 6.5
  Distortion Level: 2.5
  
Amp Selection:
  Amp: British Warm (lush, saturated)
  Cabinet: British 1x12 (Open back)
  Microphone: Ribbon (or SM57 Mid) - smooth tone
  
Effects Chain:
  Gate: OFF
  Distortion: Soft Clip (warm tube saturation)
  Modulation: CHORUS - 65% depth, 1.2Hz rate (rich shimmer)
  Delay: 500ms (quarter-note @ 120BPM)
  Reverb: Plate Reverb, 55% mix
  Master: 8/10
```

**Best Sample Types**:
- 12 String Acoustic (authentic shimmering)
- Clean Electric Guitar (layered warmth)

**Playing Tips**:
- Layer multiple chord samples together
- Use vibrato liberally for expression
- Bend strings with control
- Smooth, singing phrasing

---

## 8. DIRE STRAITS - Mark Knopfler (Clean Strat Warmth)

**Sample Recommendation**: Clean Electric Guitar - mid-range for warmth

```
ReaSampler Settings:
  Mode: Monophonic
  Volume: 0dB
  Pitch Mode: Time-stretch (preserve character)

Guitar Station S2 Configuration:
  Bass: 6.5
  Mid: 6.5
  Treble: 6.5
  Bright: OFF (warm, natural tone)
  Pre-Gain: 4.5
  Distortion Level: 0.5
  
Amp Selection:
  Amp: American Clean (Fender-style)
  Cabinet: American 2x12 (Closed back)
  Microphone: SM57 (Mid position)
  
Effects Chain:
  Gate: OFF
  Distortion: OFF (focus on clean amp breakup)
  Modulation: CHORUS - 20% depth, 0.5Hz rate (optional, light sheen)
  Delay: 300ms or 375ms if used
  Reverb: Spring Reverb, 30% mix
  Compressor: 3:1 ratio, mid threshold (sustain leveling)
  Master: 9/10
```

**Best Sample Types**:
- Clean Electric Guitar (warm, articulate)
- 12 String Acoustic (fingerstyle texture)

**Playing Tips**:
- Fingerstyle-like playing (not pick attack)
- Minimal vibrato
- Let tone speak naturally
- Dynamic control via velocity

---

## 9. METALLICA / MEGADETH - High-Gain Metal Precision

**Sample Recommendation**: Clean Electric Guitar - higher octaves for lead clarity

```
ReaSampler Settings:
  Mode: Monophonic
  Volume: 0dB
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 6.5
  Mid: 6.5
  Treble: 7.5
  Bright: ON (harmonic clarity)
  Pre-Gain: 8.5
  Distortion Level: 8.5
  
Amp Selection:
  Amp: Crunch (High-Gain British)
  Cabinet: British 2x12 (Closed back) - tight, articulate
  Microphone: SM57 (Near position)
  
Effects Chain:
  Gate: Threshold -8dB (palm-muting definition)
  Distortion: Heavy Tight (metal precision)
  Modulation: FLANGER - 15% depth, 0.5Hz rate
  Delay: 250-375ms (eighth or dotted-eighth)
  Reverb: Plate Reverb, 20% mix
  Master: 7.5/10
```

**Best Sample Types**:
- Clean Electric Guitar (high notes for harmonics)
- NLMDAGuitar (modern, clean)

**Playing Tips**:
- Palm-muted rhythm patterns
- Fast picking for percussive feel
- Harmonic divisions require clarity
- Tight, controlled sustain

---

## 10. RAGE AGAINST THE MACHINE - Tom Morello (Heavy & Experimental)

**Sample Recommendation**: Clean Electric Guitar - full range for layering

```
ReaSampler Settings:
  Mode: Polyphonic (layer multiple samples)
  Volume: +1dB
  Pitch Mode: Time-stretch

Guitar Station S2 Configuration:
  Bass: 7.5
  Mid: 5.5
  Treble: 6.5
  Bright: OFF (dark, industrial)
  Pre-Gain: 8.5
  Distortion Level: 8
  
Amp Selection:
  Amp: Crunch (High-Gain)
  Cabinet: British 4x12 (Closed back)
  Microphone: SM57 (Near position)
  
Effects Chain:
  Gate: Threshold -12dB (controlled feedback buildup)
  Distortion: Heavy Aggressive (industrial tone)
  Modulation: FLANGER - 40% depth, 1.2Hz rate (experimental)
  Delay: 375-500ms (adds rhythmic dimension)
  Reverb: Plate Reverb, 35% mix
  Master: 7/10
```

**Best Sample Types**:
- Clean Electric Guitar (transforms through effects)
- Layer multiple samples with different presets

**Playing Tips**:
- Heavy palm-muting with dynamic control
- Experiment with wah-like modulation
- Layer clean rhythms beneath heavy solos
- Controlled feedback for dramatic effect
- Use dynamics - quiet rhythms exploding into heavy solos

---

## Police Sounds - Emergency & Siren Effects

For dramatic sound design and transitions:

```
Sample Files Location: GuitarSampler/samples/Police/

Recommended Setup:
  - Use ReaSampler to load police sample
  - Apply Guitar Station S2 for creative processing
  - Use heavy modulation/distortion for sci-fi effect
  - Combine with delay/reverb for atmosphere

Preset: Police Siren Through Heavy Distortion
  Bass: 8, Mid: 5, Treble: 6, Distortion: 8
  Delay: 500ms, Reverb: 50%
  Result: Industrial, sci-fi siren effect

Preset: Ambient Police Wash
  Bass: 6, Mid: 5, Treble: 7, Distortion: 2
  Chorus: 70% 0.5Hz, Delay: 1000ms, Reverb: 70%
  Result: Spacey, atmospheric siren pads
```

---

## Workflow: Creating a Complete Song

1. **Foundation Track**
   - Police Siren with heavy reverb (intro texture)
   - 4 bars

2. **Add Bass Layer**
   - Synth bass or clean sample (Dire Straits tone)
   - Monophonic, steady

3. **Add Rhythm**
   - Nirvana tone, power chords (heavy compression)
   - Rhythmic, driving

4. **Add Harmony**
   - Queen tone, 12-string chords (lush chorus/reverb)
   - Full, orchestral

5. **Lead Solo**
   - Gilmour tone, clean electric (sustained, singing)
   - Melodic, expressive

6. **Bridge/Transition**
   - Hendrix tone, heavy fuzz (dramatic, powerful)
   - Building tension

7. **Finale**
   - Layer all tones together (Gilmour + Queen + Nirvana)
   - Crescendo to full mix

---

## Tips for Best Results

### Sample Selection
- Choose samples at root pitch (C4 is universal)
- Monophonic samples for lead tones
- Polyphonic samples for pads/chords
- Mix articulations (pluck, vibrato, slides)

### Layering
- Combine 12-string with clean electric (classic combo)
- Use different presets on same sample for complexity
- Layer two Gilmour samples for richness
- Double Hendrix with second track for power

### Processing
- Trust the presets as starting points
- Adjust Master on each track for balance
- Use Reaper's volume automation for expression
- Add EQ between ReaSampler and Guitar Station S2 for brightness

### MIDI Performance
- Play with varied velocity for dynamics
- Use mod wheel for vibrato expression
- Record multiple takes and layer them
- Humanize timing for organic feel

---

Each preset is a complete starting point. Feel free to tweak and customize! 🎸✨
