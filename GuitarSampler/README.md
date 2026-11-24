# Guitar Sampler + Rig

**Sample-based guitar instrument combining pre-recorded guitar samples with the Tukan Studios Guitar Station S2 rig.**

This instrument allows you to:
- Play pre-recorded guitar samples from the sample library
- Apply any of the **10 legendary guitar tones** (Gilmour, Beatles, Hendrix, etc.)
- Transform sampled guitar recordings through classic amp and effects rigs
- Create layered guitar textures with different presets

## How It Works

1. **Guitar Samples**: Uses Reaper's ReaSampler to load and playback pre-recorded guitar samples
2. **Guitar Station S2 Rig**: Routes through Tukan's amp simulator with cabinet, microphone, and effects
3. **Preset Chains**: Each legendary tone is saved as an FX chain preset
4. **MIDI Playback**: Trigger samples via MIDI keyboard

## Sample Libraries Available

- **12 String Acoustic** - Jangly, shimmering acoustic tone
- **Clean Electric Guitar** - Bright, articulate electric tones
- **Classic Electric (RJS v1.1)** - Vintage electric guitar samples
- **NLMDAGuitar** - Modern electric guitar library
- **Pianobook Package** - Community guitar samples

## Setup Instructions

### Method 1: Use FX Chain Templates (Easiest)

1. Create a new audio track in Reaper
2. Add Reaper's **ReaSampler** plugin
3. Load guitar samples from the library
4. Add **Guitar Station S2** after ReaSampler
5. Load an FX chain template from `GUITAR_SAMPLER_PRESETS.md`
6. Adjust sample playback and effects to taste

### Method 2: Track Template with All Instruments

Alternatively, we provide track templates for each legendary tone that have:
- ReaSampler pre-configured with common samples
- Guitar Station S2 rig pre-configured
- Routing already set up

## 10 Legendary Guitar Presets

| # | Artist/Style | Character | Best For |
|----|--------------|-----------|----------|
| 1 | **Gilmour** | Warm sustaining lead | Melodic solos, sustained tones |
| 2 | **The Beatles** | Jangly bright clean | Rhythm chords, arpeggios |
| 3 | **Hendrix** | Heavy fuzz & sustain | Aggressive leads, power |
| 4 | **Deep Purple** | Thick overdrive | Hard rock riffs, sustain |
| 5 | **Iron Maiden** | Bright metal crunch | Harmonic leads, precision |
| 6 | **Nirvana** | Grunge wall of sound | Power chords, rhythm |
| 7 | **Queen** | Lush orchestral | Warm leads, harmonic layering |
| 8 | **Dire Straits** | Clean strat warmth | Fingerstyle, articulation |
| 9 | **Metallica/Megadeth** | High-gain metal | Tight riffs, definition |
| 10 | **Rage Against Machine** | Heavy experimental | Funky rhythms, effects |

## Police Sounds

The instrument also includes **Police Siren & Emergency Sounds** for sound design:
- Police sirens (various styles)
- Ambulance tones
- Fire truck sounds
- Alert sounds

Great for:
- Cinematic underscore
- Sound effects tracks
- Experimental music
- Dramatic transitions

## Workflow Example

```
1. Create audio track: "Sampled Guitar - Gilmour Tone"
2. Add ReaSampler plugin
   ↓ Load: Guitars/Clean Electric/C4.wav
3. Add Guitar Station S2
   ↓ Apply: Gilmour preset (from GUITAR_SAMPLER_PRESETS.md)
4. Play MIDI notes on your keyboard
   ↓ Triggers sample playback with Gilmour's warm reverb/chorus
5. Layer multiple tracks with different samples & presets
```

## Tips & Tricks

### Layering Samples
- Combine 12-string acoustic with clean electric for richness
- Double a sample with the same tone but different volume for width
- Layer two different presets on same sample for complex timbre

### Creating Custom Tones
1. Start with a preset
2. Adjust Bass/Mid/Treble in Guitar Station S2
3. Experiment with different amp/cabinet combinations
4. Save as new FX preset when you like it

### Sample Selection
- **Fast solos**: Use shorter attack samples (pluck, pick)
- **Sustained tones**: Use samples with natural decay
- **Rhythmic patterns**: Layer multiple short samples
- **Atmospheric**: Use long-decay samples with heavy reverb

### Effects Chain Tips
- Increase chorus depth on 12-string samples (natural shimmer)
- Use delay for rhythmic interest (quarter-note or dotted-eighth)
- Reverb works great with clean electric samples
- Distortion can be added even to acoustic samples

## Finding Samples in Reaper

ReaSampler has a file browser. Navigate to:
```
Guitar/samples/Guitars/[Guitar Type]/Samples/
```

Look for:
- `.wav` files for audio samples
- Files labeled with note names (C4, D4, etc.) for mapped samples
- Files with articulations (slap, vibrato, etc.) for variety

## Combining with Other Instruments

For complete arrangements:
- **Mellotron** for lush string pads
- **Synth** for bass and leads
- **Organ** for harmonic bed
- **Piano** for melodic support
- **Guitar Sampler** for rhythmic/lead guitar
- **Drums** for rhythm section

Create a full band by layering all instruments!

## About the Police Sounds

The Police Sounds category provides emergency and siren effects:
- Use for dramatic sound design
- Perfect for action/thriller underscore
- Great for transitions and stabs
- Can be heavily processed through the guitar rig for creative effects

## Customization

You can:
1. Add your own guitar samples to the folders
2. Create new FX chain presets with custom settings
3. Mix and match samples with different rigs
4. Save track templates for quick setup

## Notes

- ReaSampler is built into Reaper (no additional installation needed)
- Guitar Station S2 must be installed (via Tukan or ReaPack)
- All guitar samples are from included Decent Sampler libraries
- Police sounds can be downloaded from royalty-free sources or created

---

Ready to create amazing guitar textures! 🎸🎛️
