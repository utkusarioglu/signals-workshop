param (
  [string]$Command,
  [string]$WorkingDirectory
)

function FunctionName {
  param (
    [string]$Command,
    [string]$WorkingDirectory
  )

  $BackgroundCommand = {
    Write-Host 'hello'
    $Command
    Write-Host 'done'
  }

  $TempFolder = [System.IO.Path]::GetTempPath()
  $TempFileName = [System.IO.Path]::GetRandomFileName() + ".ps1"
  $TaskScript = Join-Path $TempFolder $TempFileName
  $BackgroundCommand | Set-Content -Path $TaskScript -Encoding UTF8
  $startInfo = New-Object System.Diagnostics.ProcessStartInfo
  $startInfo.FileName = "cmd.exe"
  $startInfo.Arguments = "/c start /b pwsh -NoExit -File `"$TaskScript`""
  $startInfo.CreateNoWindow = $True
  $startInfo.UseShellExecute = $False

  $proc = [System.Diagnostics.Process]::Start($startInfo)

  return $proc.Id
}

FunctionName -Command "${Command}" -WorkingDirectory "${WorkingDirectory}"
