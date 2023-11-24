. scripts\utils\SuperCollider.ps1


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

Watch-Scd @args
