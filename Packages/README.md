# Packages (quick install with REAPER's `.ReaperPkg`)

REAPER **7.86** (November 2026) added a native package format, `.ReaperPkg`, for easy install and uninstall of JSFX, scripts, extensions and
more ([format spec](https://www.reaper.fm/sdk/reaper-package-info.txt)). This folder builds one package per instrument so you can install an
instrument by opening a single file - no scripts, no folder links.

> You need **REAPER 7.86 or newer**. Older versions don't know the format.

## Build the packages

```powershell
powershell -ExecutionPolicy Bypass -File .\Build-Packages.ps1              # all of them  -> dist\
powershell -ExecutionPolicy Bypass -File .\Build-Packages.ps1 -Only Organ,Synth
```

| Package | Contains | Size |
|---------|----------|------|
| `ReaperInstruments-Organ` | OrganSingle + the original Lord of the Rinks, demo template | tiny |
| `ReaperInstruments-Synth` | Retro Synth, demo template | tiny |
| `ReaperInstruments-Drums` | Drums plugin, kit maps, the 5 kit files, demo template | ~22 MB |
| `ReaperInstruments-Guitar` | Guitar plugin, maps, samples, FX chain, demo template | ~330 MB |
| `ReaperInstruments-Piano` | Piano plugin, maps, samples, demo template | ~900 MB |
| `ReaperInstruments-Mellotron` | Mellotron plugin, the 24 DecenTron tape sets, demo template | ~540 MB |
| `ReaperInstruments-GuitarRig` | Guitar Station S2 (Tukan) + FX chain + demo | ~29 MB, **local use only** |
| `ReaperInstruments-BassRig` | Bass Station S2 (Tukan) + FX chain + demo | ~30 MB, **local use only** |
| `ReaperInstruments-DemoSong` | the all-instruments demo song as a project template | tiny |

A package is a zip: `reaper-package-info.txt` (NAME, AUTHOR, VERSION, URL, INFO) and the files under REAPER's own folders
(`Effects/...`, `Data/...`, `FXChains/...`, `ProjectTemplates/...`). The samples go straight into `Data/`, which is what the plugins read.
Demo projects install as **project templates** (File -> New project from template).

## Install

1. Update REAPER to 7.86 or newer.
2. If you used the `Install-*.ps1` scripts before, run `Remove-SampleLinks.ps1` once. It removes only the folder links those scripts made
   (never the sample files), so the packages can install real files in their place.
3. Open each `.ReaperPkg` in REAPER (double-click it or drag it onto REAPER's window - the exact install flow is REAPER's own),
   starting with the instruments you want. Install the Demo Song package last (it needs the others).
4. Restart REAPER or re-scan JS effects if a plugin doesn't show up.

Uninstall works through REAPER's package handling as well.

## Important: don't publish `dist\`

* The sample packages contain **third-party samples** (DecenTron, the Decent Sampler pianos and guitars, the AVL drum kits) under their own licenses.
* The two rig packages contain **Tukan Studios' plugin files, which have no declared license**.

`dist\` is git-ignored. Keep the packages for your own machines, or check each license before sharing a package.
(The no-samples parts - Organ, Synth, the plugins themselves - are free to share under this repository's terms, but the packages above bundle
the samples, so share the repository and the install scripts instead.)
