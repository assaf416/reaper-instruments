# Bass Rig

**Bass Station S2** by Tukan Studios - the bass counterpart of the [Guitar Rig](../GuitarRig/README.md). It is a bass amp,
cabinet and effects chain with its own graphic UI, for any bass track or DI signal:

* **Input order, pre-gain, input compressor, output** and a noise **gate** (threshold / release)
* **Bass / Mid / Treble / Bright** tone controls
* **Amps, cabinets, mics and mic position**
* **Chorus, flanger** and more modulation, saturation / drive stages

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-BassRig.ps1
```

This installs the plugin into `REAPER\Effects\BassRig\` (its own folder - your ReaPack-managed `Effects\Tukan` and the Guitar
Rig's folder are never touched) and an FX chain **Bass Rig** into `REAPER\FXChains\`. In REAPER: **FX -> chain menu -> Bass Rig**,
or add *Bass Station S2 (Tukan)* on any bass track.

Demo project: `projects\BassRig_Demo.rpp` - there is no bass instrument in this repository, so the demo plays a bass line on the
low notes of the Guitar sampler (Strat, no chorus or delay) through the rig. Install the Guitar first (`..\Guitar\Install-Guitar.ps1`)
to hear it; for real use, put the rig on a recorded bass or DI track.

Where the files come from:

1. `vendor\` if it exists (made with `Build-BassRig-Assets.ps1` from your Tukan install), otherwise
2. your own ReaPack install of the Tukan Studios package (`REAPER\Effects\Tukan`) - `manifest.txt` is the list of the 90 files the plugin
   needs (the plugin, 21 DSP include files, 26 images and 42 impulse-response / cabinet files).

If you don't have the Tukan package yet: **Extensions -> ReaPack -> Import repositories**, add
`https://github.com/TukanStudios/TUKAN_STUDIOS_PLUGINS/raw/main/index2.xml`, then Browse packages and install the Series 2 package.

## Notes

* **No license upstream.** Tukan Studios' repository does not declare a license, so the plugin files are *not* part of this repository
  (`vendor\` is git-ignored). Only the scripts, manifest, FX chain, demo project and docs are.
* The plugin declares 70 files that are **not present** in the ReaPack install on this machine (full-length cabinet impulse responses
  under `S2GFX\GitAmp\` and `S2GFX\BassAmp\`, plus one image); only small placeholder files are there. If a cabinet sounds thin, check the
  upstream repository for them.
* This is a separate copy of the shared Tukan libraries from the Guitar Rig (about 30 MB each) so the two rigs stay independent.

## Credits

See [CREDITS.md](CREDITS.md).
