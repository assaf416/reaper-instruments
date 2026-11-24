# Build-GeneralMidi-Assets.ps1
# Reads a SoundFont 2 file (default: ..\fluid-gm2\FluidR3_GM2-2.SF2, "Fluid R3 GM") and writes everything GeneralMIDI.jsfx needs:
#   samples\NNNN_<name>.wav       EVERY sample of the SoundFont as a mono 16-bit WAV (original sample rate)
#   samples\index.txt             sample id, file name, sample rate, frames
#   maps\presets.txt              one line per preset:  bank program name
#   maps\p_BBB_PPP.txt            zones of preset (bank BBB, program PPP):
#                                 first line = zone count, then one line of numbers per zone:
#       keyLo keyHi velLo velHi sampleId rootKey tuneCents scaleTuning pan attenuationCb loopMode startFrame length
#       loopStart loopEnd sampleRate exclusiveClass delay attack hold decay sustainCb release filterFcCents reverbSend
#     (times in seconds; loopMode 0 none / 1 loop / 3 loop until key release; loop and length in frames of the sample's own WAV)
#   maps\p_BBB_PPP_files.txt      the WAV path of every zone, relative to REAPER's Data folder (GeneralMIDI/samples/...)
# The SoundFont's presets / instruments / generators are resolved the standard way (instrument generators, preset generators added on top).
#
#   powershell -ExecutionPolicy Bypass -File .\Build-GeneralMidi-Assets.ps1

param(
  [string]$Sf2 = (Join-Path (Split-Path $PSScriptRoot -Parent) 'fluid-gm2\FluidR3_GM2-2.SF2'),
  [string]$OutDir = $PSScriptRoot
)
if (-not (Test-Path $Sf2)) { throw "SoundFont not found: $Sf2" }

$code = @'
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

public static class Sf2X
{
    static CultureInfo IC = CultureInfo.InvariantCulture;
    static int U16(byte[] d, int o) { return d[o] | (d[o + 1] << 8); }
    static int S16(byte[] d, int o) { return (short)(d[o] | (d[o + 1] << 8)); }
    static uint U32(byte[] d, int o) { return (uint)(d[o] | (d[o + 1] << 8) | (d[o + 2] << 16) | (d[o + 3] << 24)); }
    static string Name(byte[] d, int o) { int n = 0; while (n < 20 && d[o + n] != 0) n++; return Encoding.ASCII.GetString(d, o, n).Trim(); }
    static string F(double v) { return v.ToString("0.####", IC); }
    static double Sec(int tc) { if (tc <= -12000) return 0.0; double s = Math.Pow(2.0, tc / 1200.0); return s > 100 ? 100 : s; }

    class Smp { public string name; public uint start, end, sl, el, rate; public int pitch, corr, link, type; public string file; }

    // generator lists of every zone between two bag indices
    static List<Dictionary<int, int>> Zones(byte[] d, int bagO, int genO, int bagA, int bagB)
    {
        var zs = new List<Dictionary<int, int>>();
        for (int b = bagA; b < bagB; b++)
        {
            int g0 = U16(d, bagO + b * 4), g1 = U16(d, bagO + (b + 1) * 4);
            var z = new Dictionary<int, int>();
            for (int g = g0; g < g1; g++)
            {
                int op = U16(d, genO + g * 4);
                int amt = (op == 43 || op == 44) ? U16(d, genO + g * 4 + 2) : S16(d, genO + g * 4 + 2);
                z[op] = amt;
            }
            zs.Add(z);
        }
        return zs;
    }
    static Dictionary<int, int> Merge(Dictionary<int, int> glob, Dictionary<int, int> loc)
    {
        var m = new Dictionary<int, int>();
        if (glob != null) foreach (var kv in glob) m[kv.Key] = kv.Value;
        foreach (var kv in loc) m[kv.Key] = kv.Value;
        return m;
    }
    static int Get(Dictionary<int, int> a, int op, int def) { int v; return a.TryGetValue(op, out v) ? v : def; }

    public static string Run(string sf2, string outDir)
    {
        byte[] d = File.ReadAllBytes(sf2);
        int smplO = -1, smplLen = 0;
        int phdrO = 0, phdrN = 0, pbagO = 0, pgenO = 0, instO = 0, instN = 0, ibagO = 0, igenO = 0, shdrO = 0, shdrN = 0;
        int pos = 12;
        while (pos + 8 <= d.Length)
        {
            string id = Encoding.ASCII.GetString(d, pos, 4); int sz = (int)U32(d, pos + 4); int body = pos + 8;
            if (id == "LIST")
            {
                string lt = Encoding.ASCII.GetString(d, body, 4);
                int p = body + 4, end = body + sz;
                while (p + 8 <= end)
                {
                    string sid = Encoding.ASCII.GetString(d, p, 4); int ssz = (int)U32(d, p + 4); int sb = p + 8;
                    if (lt == "sdta" && sid == "smpl") { smplO = sb; smplLen = ssz; }
                    else if (lt == "pdta")
                    {
                        switch (sid)
                        {
                            case "phdr": phdrO = sb; phdrN = ssz / 38; break;
                            case "pbag": pbagO = sb; break;
                            case "pgen": pgenO = sb; break;
                            case "inst": instO = sb; instN = ssz / 22; break;
                            case "ibag": ibagO = sb; break;
                            case "igen": igenO = sb; break;
                            case "shdr": shdrO = sb; shdrN = ssz / 46; break;
                        }
                    }
                    p = sb + ssz + (ssz & 1);
                }
            }
            pos = body + sz + (sz & 1);
        }
        if (smplO < 0 || phdrN < 2 || shdrN < 2) throw new Exception("not a valid SoundFont 2 file");

        string sampDir = Path.Combine(outDir, "samples"), mapDir = Path.Combine(outDir, "maps");
        Directory.CreateDirectory(sampDir); Directory.CreateDirectory(mapDir);

        // ---- samples -> WAV files ----
        var smps = new List<Smp>();
        var index = new StringBuilder();
        long wavBytes = 0; int wavCount = 0;
        for (int i = 0; i < shdrN - 1; i++)
        {
            int o = shdrO + i * 46;
            var s = new Smp();
            s.name = Name(d, o); s.start = U32(d, o + 20); s.end = U32(d, o + 24); s.sl = U32(d, o + 28); s.el = U32(d, o + 32);
            s.rate = U32(d, o + 36); s.pitch = d[o + 40]; s.corr = (sbyte)d[o + 41]; s.link = U16(d, o + 42); s.type = U16(d, o + 44);
            smps.Add(s);
            if ((s.type & 0x8000) != 0 || s.end <= s.start) continue;
            long frames = s.end - s.start;
            if ((s.start + frames) * 2 > smplLen) continue;
            string fn = string.Format("{0:D4}_{1}.wav", i, Regex.Replace(s.name, "[^A-Za-z0-9._-]+", "_"));
            s.file = fn;
            using (var fs = new FileStream(Path.Combine(sampDir, fn), FileMode.Create))
            using (var w = new BinaryWriter(fs))
            {
                int dataLen = (int)(frames * 2);
                w.Write(Encoding.ASCII.GetBytes("RIFF")); w.Write(36 + dataLen); w.Write(Encoding.ASCII.GetBytes("WAVE"));
                w.Write(Encoding.ASCII.GetBytes("fmt ")); w.Write(16); w.Write((short)1); w.Write((short)1);
                w.Write((int)s.rate); w.Write((int)s.rate * 2); w.Write((short)2); w.Write((short)16);
                w.Write(Encoding.ASCII.GetBytes("data")); w.Write(dataLen);
                w.Write(d, smplO + (int)s.start * 2, dataLen);
                wavBytes += 44 + dataLen;
            }
            wavCount++;
            index.AppendLine(string.Format("{0} {1} {2} {3}", i, fn, s.rate, frames));
        }
        File.WriteAllText(Path.Combine(sampDir, "index.txt"), index.ToString(), new UTF8Encoding(false));

        // ---- presets ----
        var presetsTxt = new StringBuilder();
        int presetsWritten = 0, zonesTotal = 0; long maxFrames = 0; string maxName = "";
        var list = new List<KeyValuePair<int, string>>();
        for (int i = 0; i < phdrN - 1; i++)
        {
            int ho = phdrO + i * 38;
            string pname = Name(d, ho);
            int prog = U16(d, ho + 20), bank = U16(d, ho + 22), bagA = U16(d, ho + 24), bagB = U16(d, phdrO + (i + 1) * 38 + 24);
            var pz = Zones(d, pbagO, pgenO, bagA, bagB);
            Dictionary<int, int> pGlobal = (pz.Count > 0 && !pz[0].ContainsKey(41)) ? pz[0] : null;

            var lines = new StringBuilder(); var files = new StringBuilder(); int nz = 0;
            var used = new HashSet<int>(); long frames = 0;
            foreach (var pLocal in pz)
            {
                if (!pLocal.ContainsKey(41)) continue;
                var p = Merge(pGlobal, pLocal);
                int ins = p[41]; if (ins < 0 || ins >= instN - 1) continue;
                int ib0 = U16(d, instO + ins * 22 + 20), ib1 = U16(d, instO + (ins + 1) * 22 + 20);
                var iz = Zones(d, ibagO, igenO, ib0, ib1);
                Dictionary<int, int> iGlobal = (iz.Count > 0 && !iz[0].ContainsKey(53)) ? iz[0] : null;
                foreach (var iLocal in iz)
                {
                    if (!iLocal.ContainsKey(53)) continue;
                    var ig = Merge(iGlobal, iLocal);
                    int sid = ig[53]; if (sid < 0 || sid >= smps.Count || smps[sid].file == null) continue;
                    var sm = smps[sid];

                    int kl = 0, kh = 127, vl = 0, vh = 127;
                    if (ig.ContainsKey(43)) { kl = ig[43] & 0xFF; kh = (ig[43] >> 8) & 0xFF; }
                    if (p.ContainsKey(43)) { kl = Math.Max(kl, p[43] & 0xFF); kh = Math.Min(kh, (p[43] >> 8) & 0xFF); }
                    if (ig.ContainsKey(44)) { vl = ig[44] & 0xFF; vh = (ig[44] >> 8) & 0xFF; }
                    if (p.ContainsKey(44)) { vl = Math.Max(vl, p[44] & 0xFF); vh = Math.Min(vh, (p[44] >> 8) & 0xFF); }
                    if (kl > kh || vl > vh) continue;

                    Func<int, int, int> V = (op, def) => Get(ig, op, def) + Get(p, op, 0);
                    int root = Get(ig, 58, -1); if (root < 0 || root > 127) root = sm.pitch;
                    int cents = V(51, 0) * 100 + V(52, 0) + sm.corr;
                    int scale = V(56, 100);
                    int pan = Math.Max(-500, Math.Min(500, V(17, 0)));
                    int att = Math.Max(0, V(48, 0));
                    int mode = Get(ig, 54, 0) & 3; if (mode == 2) mode = 0;
                    int excl = Get(ig, 57, 0);
                    long wavLen = sm.end - sm.start;
                    long startFrame = Math.Max(0, (long)Get(ig, 0, 0) + 32768L * Get(ig, 4, 0));
                    long endFrame = wavLen + Get(ig, 1, 0) + 32768L * Get(ig, 12, 0);
                    if (endFrame > wavLen) endFrame = wavLen; if (endFrame <= startFrame + 1) continue;
                    long ls = (long)sm.sl - sm.start + Get(ig, 2, 0) + 32768L * Get(ig, 45, 0);
                    long le = (long)sm.el - sm.start + Get(ig, 3, 0) + 32768L * Get(ig, 50, 0);
                    if (mode != 0 && (le <= ls + 8 || ls < 0 || le > wavLen)) mode = 0;
                    int sus = Math.Max(0, Math.Min(1440, V(37, 0)));
                    int fc = V(8, 13500); int rev = Math.Max(0, Math.Min(1000, V(16, 0)));

                    lines.AppendLine(string.Join(" ", new string[] {
                        kl.ToString(), kh.ToString(), vl.ToString(), vh.ToString(), sid.ToString(), root.ToString(), cents.ToString(), scale.ToString(),
                        pan.ToString(), att.ToString(), mode.ToString(), startFrame.ToString(), endFrame.ToString(), ls.ToString(), le.ToString(),
                        sm.rate.ToString(), excl.ToString(), F(Sec(V(33, -12000))), F(Sec(V(34, -12000))), F(Sec(V(35, -12000))), F(Sec(V(36, -12000))),
                        sus.ToString(), F(Sec(V(38, -12000))), fc.ToString(), rev.ToString() }));
                    files.AppendLine("GeneralMIDI/samples/" + sm.file);
                    nz++; zonesTotal++;
                    if (used.Add(sid)) frames += sm.end - sm.start;
                }
            }
            if (nz == 0) continue;
            string tag = string.Format("p_{0:D3}_{1:D3}", bank, prog);
            File.WriteAllText(Path.Combine(mapDir, tag + ".txt"), nz + "\n" + lines.ToString().Replace("\r", ""), new UTF8Encoding(false));
            File.WriteAllText(Path.Combine(mapDir, tag + "_files.txt"), files.ToString().Replace("\r", ""), new UTF8Encoding(false));
            list.Add(new KeyValuePair<int, string>(bank * 1000 + prog, string.Format("{0} {1} {2}", bank, prog, pname)));
            presetsWritten++;
            if (frames > maxFrames) { maxFrames = frames; maxName = string.Format("{0}:{1} {2}", bank, prog, pname); }
        }
        list.Sort((a, b) => a.Key.CompareTo(b.Key));
        foreach (var kv in list) presetsTxt.Append(kv.Value).Append("\n");
        File.WriteAllText(Path.Combine(mapDir, "presets.txt"), presetsTxt.ToString(), new UTF8Encoding(false));

        return string.Format("samples written: {0} ({1:N1} MB) of {2} in the file | presets: {3} | zones: {4} | largest preset: {5} = {6:N1}M sample frames",
            wavCount, wavBytes / 1048576.0, shdrN - 1, presetsWritten, zonesTotal, maxName, maxFrames / 1e6);
    }
}
'@
Add-Type -TypeDefinition $code -Language CSharp
Write-Host "Reading $Sf2 ..."
$sw = [Diagnostics.Stopwatch]::StartNew()
$summary = [Sf2X]::Run($Sf2, $OutDir)
Write-Host $summary
Write-Host ("done in {0:N1} s -> {1}" -f $sw.Elapsed.TotalSeconds, $OutDir)
