# Guitar Rig

**Guitar Station S2** by Tukan Studios as a guitar rig for the [Guitar](../Guitar/README.md) instrument (or for any guitar track).
It is an amp-and-pedal simulation with its own graphic UI:

* **Pre boost, pre-gain, distortion level and output level**
* **Bass / Mid / Treble / Bright** tone controls
* **Four amps and four cabinets** (plus "No amp" / "No cab"), tube-style saturation with oversampling
* a pedal row, gate and modulation, a preset file with a library of ready-made rigs (`Guitar Station S2 (Tukan).RPL`)

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-GuitarRig.ps1
```

This installs the plugin into `REAPER\Effects\GuitarRig\` (its own folder - your ReaPack-managed `Effects\Tukan` is never touched)
and an FX chain **Guitar + Rig** into `REAPER\FXChains\` (Guitar instrument -> Guitar Station S2). In REAPER:
**FX -> chain menu -> Guitar + Rig**, or add *Guitar Station S2 (Tukan)* after any guitar. Demo project: `projects\GuitarRig_Demo.rpp`.
Install the Guitar instrument first (`..\Guitar\Install-Guitar.ps1`) if you want the chain's first plugin.

Where the files come from:

1. `vendor\` if it exists (made with `Build-GuitarRig-Assets.ps1` from your Tukan install), otherwise
2. your own ReaPack install of the Tukan Studios package (`REAPER\Effects\Tukan`) - `manifest.txt` is the list of the 101
   files the plugin needs (the plugin, 21 DSP include files, 22 images, the cabinet/mic files and the preset file).

If you don't have the Tukan package yet: **Extensions -> ReaPack -> Import repositories**, add
`https://github.com/TukanStudios/TUKAN_STUDIOS_PLUGINS/raw/main/index2.xml`, then Browse packages and install the Series 2 package.

## Notes

* **No license upstream.** Tukan Studios' repository does not declare a license, so the plugin files are *not* part of this
  repository (`vendor\` is git-ignored). Only the scripts, manifest, FX chain, demo project and docs are.
* The plugin declares 56 full-length cabinet impulse responses (`S2GFX\GitAmp\<amp>_<Mid|Side>_<mic>.wav`) that are **not present** in
  the ReaPack install on this machine - only tiny placeholder files (`..._dc.wav`) are. If a cabinet sounds thin, check the
  upstream repository for those files.

## Credits

See [CREDITS.md](CREDITS.md).
