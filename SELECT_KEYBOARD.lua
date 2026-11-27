-- SELECT_KEYBOARD.lua
-- Global keyboard selector for Reaper instruments
-- Allows switching between 6 keyboards with one click
-- Place in: ~/.config/REAPER/Scripts/SELECT_KEYBOARD.lua

-- Initialize keyboard definitions
local keyboards = {
  {id=0, name="M-Audio Oxygen Pro Mini (DEFAULT)", icon="🎹", channels={1}, rx_cc={7,20,21,22,23,24,25,26,74,73,71,5}},
  {id=1, name="Casio Privia PX-150", icon="🎼", channels={1,2,3}, rx_cc={7,11,64,1,11}},
  {id=2, name="Roland GO:KEYS 3", icon="🎧", channels={4}, rx_cc={1,5,7,10,11,64,65,71,72,73,74}},
  {id=3, name="Korg Nano Kontroller 2", icon="🎚️", channels={1}, rx_cc={0,1,2,3,4,5,6,7,16,17,18,19}},
  {id=4, name="M-Audio Axiom 61", icon="🎹", channels={1}, rx_cc={7,10,1,2}},
  {id=5, name="M-Wave SMC-Mixer", icon="🎛️", channels={1}, rx_cc={7,10,12,13}}
}

local current_keyboard_id = 0

-- Function to get current keyboard
function get_current_keyboard()
  return keyboards[current_keyboard_id + 1]
end

-- Function to set keyboard and broadcast MIDI CC
function select_keyboard(keyboard_id)
  if keyboard_id >= 0 and keyboard_id <= 5 then
    current_keyboard_id = keyboard_id
    local kb = get_current_keyboard()

    -- Send MIDI CC to all tracks to notify them of keyboard change
    -- Using CC#127 as a "keyboard selector" message
    local proj = reaper.EnumProjects(-1)
    if proj then
      for i = 0, reaper.CountTracks(proj)-1 do
        local track = reaper.GetTrack(proj, i)
        if track then
          -- Send CC 127 with keyboard ID (0-5) as value
          local midi_track_send = reaper.CreateMidiEventEx(track, 0, 0xB0 + (kb.channels[1]-1), 127, keyboard_id * 20)

          -- Could also use CC#126 or a Note event
          -- The instrument will check for this message in @block
        end
      end
    end

    reaper.ShowConsoleMsg("✅ Switched to: " .. kb.name .. "\n")
    reaper.ShowConsoleMsg("   MIDI Channels: " .. table.concat(kb.channels, ", ") .. "\n")
    reaper.ShowConsoleMsg("   CC Assignments: " .. table.concat(kb.rx_cc, ", ") .. "\n\n")

    return true
  end
  return false
end

-- Function to show selection menu
function show_keyboard_menu()
  gfx.init("🎹 Select MIDI Keyboard", 400, 500)
  gfx.clear = 0x1a1a1a

  local w, h = gfx.w, gfx.h
  local mouse_x, mouse_y = gfx.mouse_x, gfx.mouse_y
  local button_height = 60
  local padding = 10
  local y_offset = 20

  -- Draw title
  gfx.setcolor(100, 150, 255)
  gfx.set(1, 1, 1)
  gfx.x = padding
  gfx.y = y_offset
  gfx.drawstr("Select Your MIDI Keyboard")

  y_offset = y_offset + 40

  -- Draw keyboard buttons
  for i, kb in ipairs(keyboards) do
    local button_y = y_offset + (i-1) * (button_height + padding)
    local button_x = padding
    local button_w = w - 2*padding

    -- Check if mouse is over button
    local mouse_over = mouse_x >= button_x and mouse_x <= button_x + button_w and
                       mouse_y >= button_y and mouse_y <= button_y + button_height

    -- Draw button
    if mouse_over then
      gfx.setcolor(80, 120, 200)
    else
      gfx.setcolor(40, 60, 100)
    end
    gfx.rect(button_x, button_y, button_w, button_height, 1)

    -- Draw button border
    if kb.id == current_keyboard_id then
      gfx.setcolor(0, 255, 0)  -- Green highlight for current
    else
      gfx.setcolor(100, 150, 255)
    end
    gfx.rect(button_x, button_y, button_w, button_height, 0)

    -- Draw text
    gfx.setcolor(200, 200, 200)
    gfx.x = button_x + 15
    gfx.y = button_y + 10
    gfx.drawstr(kb.icon .. " " .. kb.name)

    if kb.id == current_keyboard_id then
      gfx.x = button_x + 15
      gfx.y = button_y + 30
      gfx.setcolor(0, 255, 0)
      gfx.drawstr("✓ ACTIVE")
    end

    -- Check for click
    if gfx.mouse_cap & 1 and mouse_over then
      select_keyboard(kb.id)
      gfx.mouse_cap = 0
    end
  end

  -- Draw info at bottom
  local kb = get_current_keyboard()
  gfx.setcolor(150, 150, 150)
  gfx.x = padding
  gfx.y = h - 100
  gfx.drawstr("Current: " .. kb.name)
  gfx.x = padding
  gfx.y = h - 80
  gfx.drawstr("Channels: " .. table.concat(kb.channels, ", "))
  gfx.x = padding
  gfx.y = h - 60
  gfx.drawstr("Click to select keyboard")
  gfx.x = padding
  gfx.y = h - 40
  gfx.drawstr("All instruments use:")
  gfx.x = padding
  gfx.y = h - 20
  gfx.drawstr("CC#50=Prev, CC#51=Next preset")

  gfx.update()
end

-- Main loop
function main()
  while gfx.getchar() >= 0 do
    show_keyboard_menu()
  end
  gfx.quit()
end

-- Start
main()

-- To use in Reaper:
-- 1. Place this file in ~/.config/REAPER/Scripts/
-- 2. In Reaper: Actions → Show Action List
-- 3. Right-click → New Action → Run Script
-- 4. Select this file (SELECT_KEYBOARD.lua)
-- 5. Add to toolbar or keymap for quick access
-- 6. Click to open keyboard selector menu
