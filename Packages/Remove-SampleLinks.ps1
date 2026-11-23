# Remove-SampleLinks.ps1
# The Install-*.ps1 scripts link the repository's sample folders into REAPER's Data folder (folder junctions).
# A .ReaperPkg installs the samples as real files in the same places, so remove those links first.
# This removes ONLY the links - the sample files in the repository are never touched (cmd's rmdir on a junction
# deletes just the link). Real folders are left alone and reported.

param(
  [string]$ReaperResources = (Join-Path $env:APPDATA 'REAPER')
)
$data = Join-Path $ReaperResources 'Data'
$links = @('DecenTron', 'Drumkits')
$links += Get-ChildItem (Join-Path $data 'Pianos') -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object { 'Pianos\' + $_.Name }
$links += Get-ChildItem (Join-Path $data 'Guitars') -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object { 'Guitars\' + $_.Name }
foreach ($rel in $links) {
  $p = Join-Path $data $rel
  if (-not (Test-Path $p)) { continue }
  $item = Get-Item $p -Force
  if ($item.LinkType -eq 'Junction') { cmd /c rmdir "`"$p`"" | Out-Null; Write-Host "removed link  Data\$rel" }
  else { Write-Host "kept (real folder)  Data\$rel" }
}
Write-Host "Done. Now install the .ReaperPkg files."
