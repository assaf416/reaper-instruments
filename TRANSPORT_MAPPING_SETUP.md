# 🎹 Oxygen Pro Mini → Transport Control Mapping

Map the 3 rightmost keys on your Oxygen Pro Mini to control Reaper's Play, Stop, and Record.

---

## 🎯 KEY ASSIGNMENTS

```
┌─────────────────────────────────────────────┐
│   OXYGEN PRO MINI TRANSPORT CONTROL KEYS    │
├─────────────────────────────────────────────┤
│  KEY 32 (Highest, B2, Note 59)              │
│  ► Press to PLAY/PAUSE ▶️                   │
│                                             │
│  KEY 31 (Second from top, A#2, Note 58)    │
│  ► Press to STOP ⏹️                         │
│                                             │
│  KEY 30 (Third from top, A2, Note 57)      │
│  ► Press to RECORD 🔴                       │
└─────────────────────────────────────────────┘
```

---

## METHOD 1: Reaper MIDI Learn (Easiest) ✅

This is the simplest and most reliable method.

### Step 1: Open MIDI Learn
1. In Reaper menu: **Options → MIDI Learn**
2. A floating window appears: "MIDI learn"
3. Leave it open

### Step 2: Map Play/Pause (Key 32)
1. In the MIDI Learn window, click: **Learn** button
2. Press **KEY 32** (the rightmost/highest key on Oxygen Pro)
3. The window will show: `Note On, Ch 1, Note 59`
4. In the input field below, type the action: `1016` (or search "Play/Pause")
   - Or click the "..." button to search for "Transport: Play" action
5. Click **Learn** again to confirm
6. You should see it listed in the window

### Step 3: Map Stop (Key 31)
1. Click **Learn** button again
2. Press **KEY 31** (second from top)
3. Type action: `1017` (Transport: Stop)
4. Click **Learn** again

### Step 4: Map Record (Key 30)
1. Click **Learn** button again
2. Press **KEY 30** (third from top)
3. Type action: `1013` (Transport: Record)
4. Click **Learn** again

### Step 5: Test
1. Close MIDI Learn window
2. Press Key 32 → Should **Play**
3. Press Key 31 → Should **Stop**
4. Press Key 30 → Should **Record**

---

## METHOD 2: Lua Script (Advanced)

If you want a visual indicator script that shows what's happening:

1. Save the script: `~/.config/REAPER/Scripts/Transport_Controller.lua`
2. In Reaper: **Actions → Show Action List**
3. Right-click → **New Action → Script: Run script**
4. Select `Transport_Controller.lua`
5. The console will show when you press each key

---

## ACTION IDs (For Reference)

| Action | ID | Description |
|--------|----|----|
| Play/Pause | 1016 | Toggle playback |
| Stop | 1017 | Stop playback |
| Record | 1013 | Toggle record mode |
| Record: Toggle new item on input | 1014 | Record into new item |
| Pause | 1008 | Pause playback |

---

## 🎼 IMPORTANT NOTES

⚠️ **These keys are NOW for transport control, not organ playing!**
- Keys 1-29 (C0 to G#2) are still available for organ
- Keys 30-32 are reserved for transport
- If you want to use all 32 keys for organ, see "Alternative Mapping" below

---

## ALTERNATIVE: Use Mod Wheel Zone Instead

If you want to keep all 32 keys for organ playing, use a **key combination**:

- **Hold Mod Wheel + Press C2 Key** = Play
- **Hold Mod Wheel + Press D2 Key** = Stop
- **Hold Mod Wheel + Press E2 Key** = Record

This requires a more complex script. Let me know if you want this setup instead.

---

## 🔧 TROUBLESHOOTING

**Keys aren't working:**
- Make sure Oxygen Pro Mini is in the MIDI Devices list (Preferences → Audio/MIDI)
- Try pressing the keys harder (they might have a low velocity threshold)
- Restart Reaper after setting up MIDI Learn

**Keys trigger but wrong action:**
- Delete the mapping in MIDI Learn window
- Re-do it, making sure you press the correct key

**Keys trigger organ sound AND transport:**
- The script filters them out, but if using MIDI Learn directly, you may hear the organ
- Use the Lua script version instead to suppress the note event

---

## 📋 QUICK REFERENCE

After setup, your Oxygen Pro Mini transport layout:

```
  ┌─────────────────────────┐
  │ ⚫ ⚫ ⚫ ⚫ ⚫ ... 🔴 ⏹️ ▶️  │  Keys 30-32
  │ Organ Keys → Transport   │
  └─────────────────────────┘
```

**Playing the organ:**
- Left 29 keys = Normal organ playing
- Right 3 keys = Transport control

---

Enjoy! 🎵
