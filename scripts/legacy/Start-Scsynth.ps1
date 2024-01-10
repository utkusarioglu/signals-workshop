. scripts\SuperCollider.ps1
# $WorkingDirectory = @(
#   $(Get-Location).Path.Split("::")[1]
#   "src\supercollider"
# ) -Join "\"

# $ExtensionsAbspath = @($WorkingDirectory, "extensions") -Join "\"

# function Start-ScSynth {
#   $ScsynthParams = @(
#     "-t", 57110,
#     "-B", "0.0.0.0",
#     "-l", 32,
#     # "-H", "ASIO : Focusrite USB ASIO" # Overloads on right channel if this is used
#     "-H", "Windows WASAPI : Analogue 1 + 2"
#   )

#   scsynth.exe @ScsynthParams 
# }

Start-ScSynth
