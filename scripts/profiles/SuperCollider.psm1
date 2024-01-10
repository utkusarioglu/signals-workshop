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

function Start-ScSynth {
  $ScsynthParams = @(
    "-t", 57110,
    "-B", "0.0.0.0",
    "-l", 32,
    # "-H", "ASIO : Focusrite USB ASIO" # Overloads on right channel if this is used
    "-H", "Windows WASAPI : Analogue 1 + 2"
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
    [string]$Filename
  )

  $WorkingDirectory = @(
    $(Get-Location).Path.Split("::")[1]
    "src\supercollider"
  ) -Join "\"

  $SclangConfigPath = Set-MergedSclangConfigFile
  $FileAbspath = @( $WorkingDirectory, $Filename ) -Join "\"

  $FileChangeArgs = @{
    FileAbsPath = $FileAbspath
    WorkingDirectory = $WorkingDirectory
    CallbackString = "sclang.exe -l ${SclangConfigPath} ${FileAbspath}"
  }

  Watch-File @FileChangeArgs
}

Export-ModuleMember -Function Watch-Scd
Export-ModuleMember -Function Start-ScSynth
Export-ModuleMember -Function Start-ScdConsole

Export-ModuleMember -Function Start-OscServer
