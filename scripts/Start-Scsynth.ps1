$WorkingDirectory = @(
  $(Get-Location).Path.Split("::")[1]
  "src\supercollider"
) -Join "\"

$ExtensionsAbspath = @($WorkingDirectory, "extensions") -Join "\"

$ScsynthParams = @(
  # "-U", $(@(
  #   "C:\Users\utkus\AppData\Local\SuperCollider\downloaded-quarks\ScampUtils",
  #   "C:\Users\utkus\AppData\Local\SuperCollider\downloaded-quarks\JSONlib",
  #   $ExtensionsAbspath
  # ) -Join ";"),
  "-t", 57110,
  "-B", "0.0.0.0",
  "-l", 32,
  # "-H", "ASIO : Focusrite USB ASIO"
  "-H", "Windows WASAPI : Analogue 1 + 2"
)

# $ScsynthParams
# Write-Host @ScsynthParams
scsynth.exe @ScsynthParams 
# scsynth.exe -U $ExtensionsAbspath -t 57110 -B 0.0.0.0 -l 32 -H "ASIO : Focusrite USB ASIO" 
