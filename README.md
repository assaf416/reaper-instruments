# Reaper Instruments

Sampled and synthesized instruments for REAPER, written as JSFX plugins with their own graphic UI. Everything an instrument
needs (plugin, samples it uses, images, licenses, install script) lives in its own folder.

| Folder | Instrument | What it is |
|--------|-----------|------------|
| [`Mellotron/`](Mellotron/README.md) | **Mellotron** | Three tapes at once from the DecenTron library (24 tape sets), per-tape level / pan, wow & flutter, saturation |
| [`Piano/`](Piano/README.md) | **Piano** | Midnight Upright, The King's Upright, Matt's Fender Rhodes and the WurliTzer, with real velocity layers and reverb |
| [`Drums/`](Drums/README.md) | **Drums** | Five velocity-layered kits, a 7-channel mixer, reverb, and a MIDI note / CC map editor with Learn for e-drums |
| [`Guitar/`](Guitar/README.md) | **Guitar** | 62 Reissue Stratocaster, ASAT Clean, ASAT DI, with chorus and a (tempo-syncable) ping-pong delay |
| [`Organ/`](Organ/README.md) | **Organ** | Tonewheel organ with rotary speaker: *Lord of the Rinks* (original, by chmaha) plus a single-manual edition with a custom preset bank |

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-All.ps1
```

Or one instrument at a time: `Mellotron\Install-Mellotron.ps1`, `Piano\Install-Piano.ps1`, `Drums\Install-Drums.ps1`,
`Guitar\Install-Guitar.ps1`, `Organ\Install-Organ.ps1`. Each one

* copies the `.jsfx` into REAPER's `Effects` folder,
* copies the small sample maps into REAPER's `Data` folder,
* links the instrument's `samples` folder into REAPER's `Data` folder (a folder junction - nothing big is copied,
  and the link is re-pointed if you move this repository).

Then in REAPER: **FX -> Add**, search for the instrument name. Each folder has a `projects` folder with a demo project.

## Layout of an instrument folder

```
<Instrument>/
  <Instrument>.jsfx        the plugin
  Install-<Instrument>.ps1 installs it into REAPER
  Build-<...>-Assets.ps1   (maintainers) rebuilds samples/ and maps/ from the original libraries
  samples/                 the samples the instrument plays (only the ones it uses)
  maps/                    sample maps generated from the libraries' own preset files
  images/ resources/ licenses/   kit photos, skins, readmes, preset files, license texts
  projects/                demo REAPER projects
```

## Samples and licenses

The `samples` folders contain third-party sample libraries copied from a local Decent Sampler installation
(DecenTron, the pianos, the guitars) and from REAPER's "DSP to JSFX" collection (the drum kits).
They keep their own licenses - see the readme / license files next to them, and [`Drums/CREDITS.md`](Drums/CREDITS.md).
Check those terms before publishing or redistributing this repository.

## Requirements

REAPER 6+ on Windows (the install scripts are PowerShell). The JSFX plugins themselves are plain JSFX.
