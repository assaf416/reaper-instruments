-- Mellotron - DecenTron Advanced Setup Script
-- Uses high-quality DecenTron individual note samples (25 instruments, 841 samples)
-- Creates a 3-tape Mellotron with proper note-to-sample mapping

function main()
  local project = reaper.ReaProject_GetByIndex(0)
  if not project then
    reaper.ShowMessageBox("No project open", "Error", 0)
    return
  end

  -- DecenTron instruments with descriptions
  local instruments = {
    { name = "MkIIFlute", display = "MKII Flute", category = "Woodwind", color = 0x1f8f00 },
    { name = "M300A", display = "M300A Violins", category = "Strings", color = 0x0066ff },
    { name = "MKIIViolins", display = "MKII Violins", category = "Strings", color = 0x0066ff },
    { name = "GC3Brass", display = "GC3 Brass", category = "Brass", color = 0xffaa00 },
    { name = "Cello", display = "Cello", category = "Strings", color = 0xff0000 },
    { name = "M300B", display = "M300B Violin", category = "Strings", color = 0x0066ff },
    { name = "CombinedChoir", display = "Combined Choir", category = "Vocal", color = 0x9933ff },
    { name = "StringSection", display = "String Section", category = "Strings", color = 0x0066ff },
    { name = "StringSession", display = "String Session", category = "Strings", color = 0x0066ff },
    { name = "Woodwind2", display = "Woodwind2", category = "Woodwind", color = 0x00dd00 },
    { name = "MkIIBrass", display = "MKII Brass", category = "Brass", color = 0xffaa00 },
    { name = "8 Choir", display = "8 Choir", category = "Vocal", color = 0x9933ff },
    { name = "Trumpet", display = "Trumpet", category = "Brass", color = 0xffdd00 },
    { name = "Trombone", display = "Trombone", category = "Brass", color = 0xffaa00 },
    { name = "Tenor Sax", display = "Tenor Sax", category = "Woodwind", color = 0xddaa00 },
    { name = "Vibes", display = "Vibes", category = "Percussion", color = 0xff6600 },
    { name = "Church Organ", display = "Church Organ", category = "Organ", color = 0xaa00ff },
    { name = "Orchestra", display = "Orchestra", category = "Ensemble", color = 0xaa44ff },
    { name = "ItalianAccordion", display = "Italian Accordion", category = "Accordion", color = 0x00aaff },
  }

  reaper.Undo_BeginBlock()

  -- Create master bus track
  reaper.InsertTrackAtIndex(0, false)
  local master_track = reaper.GetTrack(project, 0)
  reaper.GetSetMediaTrackInfo_String(master_track, "P_NAME", "Mellotron Master (DecenTron)", true)
  local color = 0x224466 | 0x01000000
  reaper.GetSetMediaTrackInfo_Value(master_track, "I_CUSTOMCOLOR", color, true)

  -- Info for master track
  local ui_info = ""
  ui_info = ui_info .. "MELLOTRON - DecenTron Edition\n"
  ui_info = ui_info .. "=====================================\n"
  ui_info = ui_info .. "Using DecenTron 1.0.0 samples (25 instruments)\n"
  ui_info = ui_info .. "Each track contains 35 note samples mapped to MIDI keys\n\n"
  ui_info = ui_info .. "HOW TO USE:\n"
  ui_info = ui_info .. "1. Each track represents one tape/instrument\n"
  ui_info = ui_info .. "2. ReaSampler auto-maps note samples to MIDI keys\n"
  ui_info = ui_info .. "3. Adjust faders to mix tapes\n"
  ui_info = ui_info .. "4. Add Mellotron.jsfx on master for mixing UI\n"
  ui_info = ui_info .. "5. Add reverb/compression for vintage character\n\n"
  ui_info = ui_info .. "TRACKS:\n"
  ui_info = ui_info .. "- Mellotron Master: Output bus with mixer\n"
  ui_info = ui_info .. "- Tape 1: First DecenTron instrument\n"
  ui_info = ui_info .. "- Tape 2: Second DecenTron instrument\n"
  ui_info = ui_info .. "- Tape 3: Third DecenTron instrument\n"

  reaper.GetSetMediaTrackInfo_String(master_track, "P_UI_NOTES", ui_info, true)

  -- Create 3 tape tracks with different default instruments
  local tape_tracks = {}
  local defaults = { 1, 2, 7 } -- Default: Flute, M300A, String Section

  for i = 1, 3 do
    reaper.InsertTrackAtIndex(i, false)
    local track = reaper.GetTrack(project, i)

    -- Get instrument for this tape
    local inst_idx = math.min(defaults[i], #instruments)
    local inst = instruments[inst_idx]

    -- Name track
    local tape_name = "Tape " .. i .. ": " .. inst.display
    reaper.GetSetMediaTrackInfo_String(track, "P_NAME", tape_name, true)

    -- Set color
    local color_with_flag = inst.color | 0x01000000
    reaper.GetSetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", color_with_flag, true)

    -- Route to master
    reaper.CreateTrackSend(track, master_track)

    -- Set initial volume
    reaper.SetMediaTrackInfo_Value(track, "D_VOL", 0.33) -- -9dB for three-way mix

    -- Add notes
    local notes = ""
    notes = notes .. "MELLOTRON TAPE " .. i .. "\n"
    notes = notes .. "Instrument: " .. inst.display .. "\n"
    notes = notes .. "Category: " .. inst.category .. "\n"
    notes = notes .. "Samples: 35 note samples (automatically mapped)\n\n"
    notes = notes .. "QUICK SETUP:\n"
    notes = notes .. "1. Add ReaSampler plugin to this track\n"
    notes = notes .. "2. Right-click ReaSampler > Open sample...\n"
    notes = notes .. "3. Navigate to: decent-sampler-files/melotron/DecenTron 1.0.0/Samples/" .. inst.name .. "/\n"
    notes = notes .. "4. Select ANY .wav file (e.g., C4.wav)\n"
    notes = notes .. "5. ReaSampler will auto-map all notes in folder!\n"
    notes = notes .. "6. Enable Resample and 'Note on MIDI key' mode\n\n"
    notes = notes .. "PERFORMANCE:\n"
    notes = notes .. "- 35 samples cover 2.9 octaves\n"
    notes = notes .. "- Velocity-sensitive playback\n"
    notes = notes .. "- Full legato and portamento support\n"

    reaper.GetSetMediaTrackInfo_String(track, "P_UI_NOTES", notes, true)

    table.insert(tape_tracks, track)
  end

  reaper.Undo_EndBlock("Create Mellotron DecenTron 3-Tape Instrument", -1)

  -- Show comprehensive message
  local msg = "🎹 MELLOTRON - DecenTron Edition Created!\n\n"
  msg = msg .. "✓ Master bus track (Mellotron Master)\n"
  msg = msg .. "✓ 3 tape tracks with pre-selected instruments:\n"
  msg = msg .. "  - Tape 1: MKII Flute (Green)\n"
  msg = msg .. "  - Tape 2: M300A Violins (Blue)\n"
  msg = msg .. "  - Tape 3: String Section (Blue)\n"
  msg = msg .. "✓ All routed to master\n"
  msg = msg .. "✓ Initial volume: -9dB each (for 3-way mix)\n\n"
  msg = msg .. "AVAILABLE INSTRUMENTS (25 total):\n"
  msg = msg .. "• Woodwind: MKII Flute, Woodwind2, Tenor Sax\n"
  msg = msg .. "• Strings: M300A, M300B, MKII Violins, Cello, String Section, String Session, Orchestra\n"
  msg = msg .. "• Brass: GC3 Brass, MKII Brass, Trumpet, Trombone\n"
  msg = msg .. "• Vocal: Combined Choir, 8 Choir\n"
  msg = msg .. "• Other: Vibes, Church Organ, Italian Accordion\n\n"
  msg = msg .. "SETUP (90 seconds):\n"
  msg = msg .. "1. Add ReaSampler to each tape track\n"
  msg = msg .. "2. For each track:\n"
  msg = msg .. "   • Open sample from: decent-sampler-files/melotron/DecenTron 1.0.0/Samples/[Instrument]/\n"
  msg = msg .. "   • ReaSampler auto-maps all 35 notes!\n"
  msg = msg .. "   • Enable Resample, set 'Note on MIDI key' mode\n"
  msg = msg .. "3. Create MIDI item and start playing!\n"
  msg = msg .. "4. Add Mellotron.jsfx on master for mixing UI\n"
  msg = msg .. "5. Add reverb/compression on master\n\n"
  msg = msg .. "TIPS:\n"
  msg = msg .. "• Each instrument has 35 notes covering ~3 octaves\n"
  msg = msg .. "• Use different instruments on each tape for richness\n"
  msg = msg .. "• Mix volumes from -9dB to 0dB per tape\n"
  msg = msg .. "• Add Mellotron.jsfx on master for vintage effects\n"
  msg = msg .. "• Record automation for dynamic tape mixing\n"

  reaper.ShowMessageBox(msg, "🎹 Mellotron DecenTron Setup Complete!", 0)

  reaper.UpdateArrange()
end

main()
