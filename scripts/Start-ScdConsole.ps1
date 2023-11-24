. scripts\utils\SuperCollider.ps1

$ArtifactPath = Set-MergedSclangConfigFile

sclang.exe -l $ArtifactPath
