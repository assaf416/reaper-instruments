# Guitar

Three electric guitars from the Decent Sampler library, with a stereo chorus and a delay.

| Guitar | Library | Layers |
|--------|---------|--------|
| 62 Reissue Strat | 62 Reissue Stratocaster | 3 velocity layers |
| ASAT Clean | ASAT Classic Variations - Clean | 3 round-robins |
| ASAT DI | ASAT Classic Variations - DI | 3 round-robins |

(Legacy Knight in the same folder is a piano, and RJS Classic Electric has no sample files on disk, so neither is used.)
Each guitar plays the first 4.5-5 seconds of every note with a smooth fade; notes between the sampled keys are pitch-shifted.

## UI

* **Guitar cards** - click to load.
* **CHORUS** - Mix, Rate (0.1-5 Hz), Depth. Two modulated taps per channel for a wide stereo chorus.
* **DELAY** - Mix, Time (20-1200 ms), Feedback, Tone (darker repeats at low values), **TEMPO SYNC** (the Time bar then picks
  1/16, 1/8T, 1/8, 1/8., 1/4, 1/4., 1/2 from the host tempo) and **PING-PONG** (repeats bounce left / right).
* **OUTPUT** - volume and meter. Ctrl+click resets a control.

Signal order: guitar -> chorus -> delay -> soft limiter.

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-Guitar.ps1
```

then **FX -> Add -> Guitar**. Demo project: `projects\Guitar_Demo.rpp`.
`Build-Guitar-Assets.ps1` (maintainers) copies the used samples and resources from the Decent Sampler folder and writes `maps\`.

## Credits

Samples belong to their authors and keep their licenses - see the readme / preset files in each `samples\<guitar>\` folder.
