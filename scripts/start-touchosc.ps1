function Start-TouchOscProcesses {
  Write-Host 'Starting TouchOSC Bridge…' 

  Start-Process `
    -WorkingDirectory 'C:\Program Files (x86)\TouchOSC Bridge' `
    'TouchOSC Bridge.exe'

  Write-Host 'Starting TouchOSC in fullscreen…' 

  touchosc `
    --general.ui.editor false `
    --general.ui.fullscreen true `
    'src/touchosc/scamp.tosc'
}

Start-TouchOscProcesses
