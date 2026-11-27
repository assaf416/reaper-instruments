-- Transport_Controller.lua
-- Map Oxygen Pro Mini top 3 keys to Play/Stop/Record
-- Place in: ~/.config/REAPER/Scripts/Transport_Controller.lua
--
-- KEY MAPPING:
-- ┌─────────────────────────────────┐
-- │ Oxygen Pro Mini Transport Keys  │
-- ├─────────────────────────────────┤
-- │ KEY 32 (B2, note 59) → PLAY/PAUSE│
-- │ KEY 31 (A#2, note 58) → STOP    │
-- │ KEY 30 (A2, note 57) → RECORD   │
-- └─────────────────────────────────┘

function main()
  -- Initialize
  reaper.ShowConsoleMsg("🎹 Transport Controller Active\n")
  reaper.ShowConsoleMsg("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
  reaper.ShowConsoleMsg("KEY 32 (B2)   = PLAY/PAUSE\n")
  reaper.ShowConsoleMsg("KEY 31 (A#2)  = STOP\n")
  reaper.ShowConsoleMsg("KEY 30 (A2)   = RECORD\n")
  reaper.ShowConsoleMsg("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n")

  local last_time = 0

  while true do
    -- Get selected track
    local track = reaper.GetSelectedTrack(0, 0)
    if not track then
      reaper.defer(main)
      return
    end

    -- Get MIDI source
    local midi_source = reaper.GetMediaItemTake_Source(
      reaper.GetMediaItemTake_Item(
        reaper.GetTrackMediaItem(track, 0)
      )
    )

    -- Check for MIDI input from Oxygen Pro
    local input, msg_count = reaper.MIDI_GetEvt(track, 0, 0, 0, 0, "")

    if input then
      local retval, offset, flags, msg = reaper.MIDI_GetEvt(track, 0, 0, 0, 0, "")

      while retval do
        -- Parse MIDI message
        local byte1 = msg:byte(1)
        local byte2 = msg:byte(2)
        local byte3 = msg:byte(3)

        -- Check if Note On (0x90) from Oxygen Pro
        if byte1 == 0x90 or byte1 == 0x9F then
          local note = byte2
          local velocity = byte3

          if velocity > 0 then  -- Note On (velocity > 0)
            -- KEY 32 (B2, note 59) = PLAY/PAUSE
            if note == 59 then
              reaper.Main_OnCommand(1016, 0)  -- Transport: Play/Pause
              reaper.ShowConsoleMsg("▶️  PLAY/PAUSE (key 32)\n")

            -- KEY 31 (A#2, note 58) = STOP
            elseif note == 58 then
              reaper.Main_OnCommand(1017, 0)  -- Transport: Stop
              reaper.ShowConsoleMsg("⏹️  STOP (key 31)\n")

            -- KEY 30 (A2, note 57) = RECORD
            elseif note == 57 then
              reaper.Main_OnCommand(1013, 0)  -- Transport: Record
              reaper.ShowConsoleMsg("⚫ RECORD (key 30)\n")
            end
          end
        end

        retval, offset, flags, msg = reaper.MIDI_GetEvt(track, 0, 0, 0, 0, "")
      end
    end

    reaper.defer(main)
  end
end

main()
