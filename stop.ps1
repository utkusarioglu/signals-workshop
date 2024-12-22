Get-Process 
  | Where-Object `
    -Property ProcessName `
    -Like sc* 
  | ForEach-Object { Stop-Process $_.Id }
