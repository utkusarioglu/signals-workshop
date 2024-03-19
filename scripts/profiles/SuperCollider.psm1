function Set-MergedSclangConfigFile {
  $pwd = $(pwd).Path.Split("::")[1]
  $ArtifactPath = "$(pwd)\artifacts\sclang_config_merged.yaml"
  $DefaultConfigPath = "C:\Users\Utkus\AppData\Local\Supercollider\sclang_conf.yaml"
  $RepoConfigPath = "${pwd}\sclang_conf.yaml"

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
    SourceIdentifier = "ScsyntExited"
  }
  $ObjectEvent = Register-ObjectEvent @RegisterArgs
}

function Start-ScSynth {
  $ScsynthParams = @(
    "-t", 57110,
    # "-t", 4000,
    "-B", "0.0.0.0",
    # "-l", 32,
    # "-u", 3000,
    # "-H", "ASIO : Focusrite USB ASIO" # Overloads on right channel if this is used
    # "-H", "Windows WASAPI : Analogue 1 + 2",
    "-H", "ASIO : Focusrite USB ASIO",
    "-a", 1024,
    "-i", 8,
    "-o", 8,
    "-R", 0,
    "-C", 2,
    "-l", 32
    # ,
    # "-z", 2
  )

  scsynth.exe @ScsynthParams 
}

function Start-ScdConsole {
  $ArtifactPath = Set-MergedSclangConfigFile
  sclang.exe -l $ArtifactPath
}

function Watch-Scd {
  Param (
    [Parameter(Mandatory = $True)]
    [string]$FileRelPath,
    [string]$WorkingDirectory
  )

  $FileAbspath = @( 
    $(Get-Location).Path.Split("::")[1],
    $FileRelPath 
  ) -Join "\"

  $File = Get-ChildItem $FileAbspath
  $Filename = $File.Name
  $FileDirectoryName = $File.DirectoryName

  if($WorkingDirectory -eq "") {
    $WorkingDirectory = $FileDirectoryName
  } else {
    $WorkingDirectory = Resolve-Path $WorkingDirectory
  }

  $SclangConfigPath = Set-MergedSclangConfigFile

  $FileChangeArgs = @{
    FileAbsPath = $FileAbspath
    WorkingDirectory = $WorkingDirectory
    Filter = "*.scd"
    CallbackString = "sclang.exe -l ${SclangConfigPath} ${FileAbsPath}"
  }

  Watch-Scsynth
  Watch-File @FileChangeArgs
}

Export-ModuleMember -Function Watch-Scd
Export-ModuleMember -Function Start-ScSynth
Export-ModuleMember -Function Start-ScdConsole

Export-ModuleMember -Function Start-OscServer
