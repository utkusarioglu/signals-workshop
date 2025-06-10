function Write-Title {
  Param (
    [Parameter(Mandatory = $true)] [string] $Title
  )
  Write-Host "${Title}:" -ForegroundColor 'Green'
}

function Write-LogPath {
  Param (
    [Parameter(Mandatory = $true)] [string] $StdIn,
    [Parameter(Mandatory = $true)] [string] $StdOut
  )
  Write-Host "StdIn:  ${StdIn}" -ForegroundColor 'DarkGray'
  Write-Host "StdOut: ${StdOut}" -ForegroundColor 'DarkGray'
}

function Wait-LogLine {
  Param (
    [Parameter(Mandatory = $true)] [string] $LogPath,
    [Parameter(Mandatory = $true)] [string] $Line,
    [Parameter(Mandatory = $true)] [int] $Timeout
  )
  $Counter = 0;
  While ( $(Get-Content $LogPath -Tail 1) -ne $Line ) {
    if($Counter -eq $Timeout) {
      $WriteHostParams = @{
        Object = "Error: Start failed, check stdout file."
        ForegroundColor = 'Red'
      }
      Write-Host @WriteHostParams
      Return $False
    }
    $Counter++
    Start-Sleep -Second 1
  }

  Return $True
}

function Start-Components {
  $OscServerProcess = $Null
  $ScSynthProcess = $Null
  $SclangProcess = $Null
  $Timeout = 15

  if($ScSynthProcess -eq $Null) {
    $CallbackString="Start-Scsynth"
    $ScsynthStdOut = New-TemporaryFile
    $ScsynthStdIn = New-TemporaryFile
    $ScsynthParams = @{
      FilePath               = "pwsh.exe"
      ArgumentList           = @(
        "-NoExit",
        "-Command $CallbackString"
      ) -Join " "
      PassThru               = $True
      NoNewWindow            = $True
      RedirectStandardInput = $ScsynthStdIn
      RedirectStandardOutput = $ScsynthStdOut
    }
    $ScSynthProcess = Start-Process @ScsynthParams

    Write-Title 'Scsynth'
    $WriteLogPathParams = @{
      StdIn = $ScsynthStdIn
      StdOut = $ScsynthStdOut
    }
    Write-LogPath @WriteLogPathParams
    
    $WaitLogLineParams = @{
      LogPath = $ScsynthStdOut
      Line = "SuperCollider 3 server ready."
      Timeout = $Timeout
    }
    $Success = Wait-LogLine @WaitLogLineParams
    if(-Not $Success) {
      Return $False
    }
    Write-Host ""
  }

  if($SclangProcess -eq $Null) {
    $CallbackString = Get-SclangCommand "src\supercollider\main.scd"
    # $CallbackString = 'Watch-Scd "src\supercollider\main.scd"'
    $SclangStdOut = New-TemporaryFile
    $SclangStdIn = New-TemporaryFile
    $SclangParams = @{
      FilePath               = "pwsh.exe"
      ArgumentList           = @(
        "-NoExit",
        "-Command $CallbackString"
      ) -Join " "
      PassThru               = $True
      NoNewWindow            = $True
      RedirectStandardInput = $SclangStdIn
      RedirectStandardOutput = $SclangStdOut
    }
    $SclangProcess = Start-Process @SclangParams

    Write-Title 'Sclang'
    $WriteLogPathParams = @{
      StdIn = $SclangStdIn
      StdOut = $SclangStdOut
    }
    Write-LogPath @WriteLogPathParams

    $WaitLogLineParams = @{
      LogPath = $SclangStdOut
      Line = "Sclang ready."
      Timeout = $Timeout
    }
    $Success = Wait-LogLine @WaitLogLineParams
    if(-Not $Success) {
      Return $False
    }
    Write-Host ""
  }

  if($OscServerProcess -eq $Null) {
    $CallbackString="Start-OscServer"
    $OscServerStdOut = New-TemporaryFile
    $OscServerStdIn = New-TemporaryFile
    $OscServerParams = @{
      FilePath               = "pwsh.exe"
      ArgumentList           = @(
        "-NoExit",
        "-Command $CallbackString"
      ) -Join " "
      PassThru               = $True
      NoNewWindow            = $True
      RedirectStandardOutput = $OscServerStdOut
      RedirectStandardInput = $OscServerStdIn
    }
    $OscServerProcess = Start-Process @OscServerParams

    Write-Title 'OscServer'
    $WriteLogPathParams = @{
      StdIn = $OscServerStdIn
      StdOut = $OscServerStdOut
    }
    Write-LogPath @WriteLogPathParams
    Write-Host ""
  }

  Return $True
}

function Start-ScdUtils {
  Throw "This function is deprecated. Use: Start-ScSynth, Start-ScdConsole and start-osc-server"

  Stop-ScdUtils

  if(-Not $(Start-Components)) {
    Return
  }

  Write-Title 'ScdConsole'
  Start-ScdConsole
}

function Stop-ScdUtils {
  foreach($app in @("sclang", "scsynth")) {
    Write-Host "Stopping ${app}…"
    Get-Process -Name "${app}" -ErrorAction SilentlyContinue 
      | ForEach-Object { Stop-Process -Id $_.Id }
  }

  Write-Host "Stopping flask…"
  $CONTAINER_REPO_PATH = '/utkusarioglu-com/workshops/signals-workshop'
  $DISTRO_NAME = 'u-Boulanger'
  docker -c ${DISTRO_NAME} exec -t 'docker-signals-workshop-1' `
    bash -c "cd ${CONTAINER_REPO_PATH} && scripts/osc-server/stop-osc-server.sh"
}

Export-ModuleMember -Function Start-ScdUtils
Export-ModuleMember -Function Stop-ScdUtils
