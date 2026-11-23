-- Mellotron Setup Script for Reaper
-- Creates a 3-tape Mellotron instrument using ReaSampler
-- Author: Claude
-- Creates 4 tracks: Mix bus + 3 tape tracks

function main()
  local project = reaper.ReaProject_GetByIndex(0)
  if not project then
    reaper.ShowMessageBox("No project open", "Error", 0)
    return
  end

  -- Mellotron tape definitions
  local tapes = {
    { id = 1, name = "MKII Flute", color = 0x1f8f00 },
    { id = 2, name = "M400 Cello", color = 0xff0000 },
    { id = 3, name = "MKII 3 Violins", color = 0x0066ff },
    { id = 4, name = "Gc3 Brass", color = 0xffaa00 },
    { id = 5, name = "Gong", color = 0xff00ff },
    { id = 6, name = "M300A Violins", color = 0x00ffff },
  }

  reaper.Undo_BeginBlock()

  -- Create master bus track
  reaper.InsertTrackAtIndex(0, false)
  local master_track = reaper.GetTrack(project, 0)
  reaper.GetSetMediaTrackInfo_String(master_track, "P_NAME", "Mellotron Master", true)

  local retval, master_track_color = reaper.GetSetMediaTrackInfo_Value(master_track, "I_CUSTOMCOLOR", 0x224466)
  reaper.GetSetMediaTrackInfo_Value(master_track, "I_CUSTOMCOLOR", master_track_color | 0x01000000, true)

  -- Create UI window info
  local ui_info = ""
  ui_info = ui_info .. "MELLOTRON - Three Tape Mixer\n"
  ui_info = ui_info .. "=====================================\n"
  ui_info = ui_info .. "Created with 3 independent tape tracks\n\n"
  ui_info = ui_info .. "HOW TO USE:\n"
  ui_info = ui_info .. "1. Each track represents a tape (Flute, Cello, Violins)\n"
  ui_info = ui_info .. "2. Load ReaSampler on each track with the extracted samples\n"
  ui_info = ui_info .. "3. Adjust faders to mix tapes\n"
  ui_info = ui_info .. "4. Add effects on the master bus for color\n\n"
  ui_info = ui_info .. "TRACKS:\n"
  ui_info = ui_info .. "- Mellotron Master: Output bus\n"
  ui_info = ui_info .. "- Tape 1: MKII Flute (Green)\n"
  ui_info = ui_info .. "- Tape 2: M400 Cello (Red)\n"
  ui_info = ui_info .. "- Tape 3: MKII 3 Violins (Blue)\n"

  -- Store note in master track
  reaper.GetSetMediaTrackInfo_String(master_track, "P_UI_NOTES", ui_info, true)

  -- Create 3 tape tracks
  local tape_tracks = {}
  for i = 1, 3 do
    reaper.InsertTrackAtIndex(i, false)
    local track = reaper.GetTrack(project, i)

    -- Name track
    local tape_name = "Tape " .. i .. ": " .. tapes[i].name
    reaper.GetSetMediaTrackInfo_String(track, "P_NAME", tape_name, true)

    -- Set color
    local color_with_flag = tapes[i].color | 0x01000000
    reaper.GetSetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", color_with_flag, true)

    -- Route to master
    local master_send_index = reaper.GetTrackNumSends(track, -1)
    reaper.CreateTrackSend(track, master_track)

    -- Set initial volume
    reaper.SetMediaTrackInfo_Value(track, "D_VOL", 0.33) -- -9dB

    table.insert(tape_tracks, track)
  end

  -- Add helpful notes for sample configuration
  local notes = ""
  notes = notes .. "SAMPLE SETUP GUIDE\n"
  notes = notes .. "==================\n\n"
  notes = notes .. "Extracted samples are in: samples/Mellotron/\n\n"
  notes = notes .. "To load samples:\n"
  notes = notes .. "1. On each tape track, add ReaSampler plugin\n"
  notes = notes .. "2. Right-click ReaSampler > Open sample...\n"
  notes = notes .. "3. Load: samples/Mellotron/sample_000.wav\n"
  notes = notes .. "4. Enable 'Resample', set pitch mode to 'Note on MIDI key'\n"
  notes = notes .. "5. Record MIDI or play with keyboard\n\n"
  notes = notes .. "TIPS:\n"
  notes = notes .. "- Use different velocity ranges per tape\n"
  notes = notes .. "- Add chorus/delay on master for vintage sound\n"
  notes = notes .. "- Tape 1 volume at 1.0, fade in Tape 2 and 3\n"
  notes = notes .. "- Use MIDI CC7 or faders to mix tapes during performance\n"

  -- Create a marker or note item with instructions
  for i, track in ipairs(tape_tracks) do
    reaper.GetSetMediaTrackInfo_String(track, "P_UI_NOTES", notes, true)
  end

  reaper.Undo_EndBlock("Create Mellotron 3-Tape Instrument", -1)

  -- Show message
  local msg = "Mellotron instrument created!\n\n"
  msg = msg .. "✓ Master bus track\n"
  msg = msg .. "✓ 3 tape tracks (Green/Red/Blue)\n"
  msg = msg .. "✓ All routed to master\n\n"
  msg = msg .. "Next steps:\n"
  msg = msg .. "1. Add ReaSampler to each tape track\n"
  msg = msg .. "2. Load: samples/Mellotron/sample_000.wav\n"
  msg = msg .. "3. Create MIDI item and start playing!\n"

  reaper.ShowMessageBox(msg, "Mellotron Setup Complete", 0)

  -- Refresh arrange view
  reaper.UpdateArrange()
end

main()
