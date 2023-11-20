function Watch-Scd {
  Param (
    [Parameter(Mandatory = $True)]
    [string]$Filename
  )

  $WorkingDirectory = @(
    $(Get-Location).Path.Split("::")[1]
    "src\supercollider"
  ) -Join "\"

  $FileAbspath = @( $WorkingDirectory, $Filename ) -Join "\"

  $FileChangeArgs = @{
    FileAbsPath = $FileAbspath
    WorkingDirectory = $WorkingDirectory
    CallbackString = "sclang.exe -l sclang_conf.yaml ${FileAbspath}"
  }

  Watch-File @FileChangeArgs
}

Watch-Scd @args
