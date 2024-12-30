$ScdWslPath = "\\wsl.localhost\u-Boulanger\home\utkusarioglu\dev\workshops\signals-workshop\src\supercollider"

function Set-MergedSclangConfigFile {
  $Pwd = $(pwd).Path.Split("::")[1]
  $ArtifactPath = "$(Pwd)\artifacts\sclang_config_merged.yaml"
  $DefaultConfigPath = "C:\Users\Utkus\AppData\Local\Supercollider\sclang_conf.yaml"
  $RepoConfigPath = "${Pwd}\sclang_conf.yaml"

  yq eval-all `
    '. as $item ireduce ({}; . *+ $item)' `
    $DefaultConfigPath `
    $RepoConfigPath `
    > $ArtifactPath

  return $ArtifactPath.split("::")[1]
}

function Watch-Scsynth {
  $ScsynthRunning = Get-Process "scsynth" -ErrorAction "SilentlyContinue"
  if (-Not($ScsynthRunning)) {
    Throw "Scsyth is not running"
  }
  $RegisterArgs = @{
    InputObject = $ScsynthRunning
    EventName = "Exited"
    Action = {
      Write-Host "Scsynth Exited"
      [Environment]::Exit(0)
    }
    SourceIdentifier = "ScsynthExited"
  }
  $ObjectEvent = Register-ObjectEvent @RegisterArgs
}

function Start-ScSynth {
  $Pwd = $(pwd).Path.Split("::")[1]
  # $ScConfigPath = "${Pwd}\sc.config.json"
  $ScConfigPath = "${pwd}\sc.config.json"
  $ScConfig = Get-Content $ScConfigPath | ConvertFrom-Json 
  $Port = $ScConfig.connection.port;
  Write-Host "Starting scsynth on TCP port ${Port}…"

  $ScsynthParams = @(
    "-t", $Port
    # "-u", $Port,
    "-B", "0.0.0.0",
    
    "-H", "ASIO : Focusrite USB ASIO",
    # "-H", "ASIO : ASIO4ALL v2",

    # "-H", "ASIO : Voicemeeter AUX Virtual ASIO", # device #59 with 8 ins 8 outs)
    # "-H", "ASIO : Voicemeeter Insert Virtual ASIO", # device #60 with 22 ins 22 outs)
    # "-H", "ASIO : Voicemeeter Potato Insert Vi...", # device #61 with 34 ins 34 outs)
    # "-H", "ASIO : Voicemeeter VAIO3 Virtual ASIO", # device #62 with 8 ins 8 outs)
    # "-H", "ASIO : Voicemeeter Virtual ASIO", # device #63 with 8 ins 8 outs)
    
    "-a", 1024,
    "-i", 8,
    "-o", 8,
    "-R", 0,
    "-C", 2,
    "-l", 32,
    "-S", 96000,
    # "-S", 44100,
    "-Z", 96
    # "-v"
  )

  scsynth.exe @ScsynthParams 
}

function Start-ScdConsole {
  $ArtifactPath = Set-MergedSclangConfigFile
  sclang.exe -l ${ArtifactPath} -d ${ScdWslPath}
}

function Get-SclangCommand {
  Param (
    [Parameter(Mandatory = $True)]
    [string]$FileRelPath
  )

  $FileAbspath = @( 
    $(Get-Location).Path.Split("::")[1],
    $FileRelPath 
  ) -Join "\"

  $SclangConfigPath = Set-MergedSclangConfigFile
  Return "sclang.exe -D -d ${ScdWslPath} -l ${SclangConfigPath} ${FileAbsPath}"
}

function Watch-Scd {
  Param (
    [Parameter(Mandatory = $True)]
    [string]$FileRelPath,
    [string]$WorkingDirectory
  )

  $File = Get-ChildItem $FileAbspath
  $Filename = $File.Name
  $FileDirectoryName = $File.DirectoryName

  if($WorkingDirectory -eq "") {
    $WorkingDirectory = $FileDirectoryName
  } else {
    $WorkingDirectory = Resolve-Path $WorkingDirectory
  }

  # $SclangConfigPath = Set-MergedSclangConfigFile
  $CallbackString = Get-SclangCommand -FileRelPath $FileRelPath

  $FileChangeArgs = @{
    FileAbsPath = $FileAbspath
    WorkingDirectory = $WorkingDirectory
    Filter = "*.scd"
    # CallbackString = "sclang.exe -l ${SclangConfigPath} ${FileAbsPath}"
    CallbackString = $CallbackString
  }

  Watch-Scsynth
  Watch-File @FileChangeArgs
}

Export-ModuleMember -Function Watch-Scd
Export-ModuleMember -Function Start-ScSynth
Export-ModuleMember -Function Start-ScdConsole

Export-ModuleMember -Function Start-OscServer
Export-ModuleMember -Function Get-SclangCommand
