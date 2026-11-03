$env:PYTHONPATH = "\\wsl.localhost\u-Boulanger\home\utkusarioglu\dev\workshops\signals-workshop\src"

.venv/Scripts/Activate.ps1

Push-Location "${PWD}\src\osc_server"
try {
  & flask --app "server3" run --host "0.0.0.0" 
}
finally {
  Pop-Location
  deactivate
}
