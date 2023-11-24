# $WorkingDirectory = @(
#   $(Get-Location).Path.Split("::")[1]
#   "src\supercollider"
# ) -Join "\"

# $ExtensionsAbspath = @($WorkingDirectory, "extensions") -Join "\"

$ScsynthParams = @(
  "-t", 57110,
  "-B", "0.0.0.0",
  "-l", 32,
  # "-H", "ASIO : Focusrite USB ASIO"
  "-H", "Windows WASAPI : Analogue 1 + 2"
)

scsynth.exe @ScsynthParams 
