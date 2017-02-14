

$ErrorActionPreference = 'Stop';

$packageName = 'sql2016-clrtypes'
$softwareName = 'Microsoft System CLR Types for SQL Server 2016*'
$installerType = 'MSI' 

$silentArgs = '/qn /norestart'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
if ($installerType -ne 'MSI') {
  $validExitCodes = @(0)
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

# Both the x86 and x64 packages are installed with the same name. Remove both.
# Currently if there are other programs that depend on these packages they won't 
# be uninstalled.
if ($key.Count -eq 2) {
  $key | % { 
    $file = "$($_.UninstallString)"

    if ($installerType -eq 'MSI') {
      $sa = "$($_.PSChildName) $silentArgs"

      $file = ''

       Uninstall-ChocolateyPackage -PackageName $packageName `
                                -FileType $installerType `
                                -SilentArgs "$sa" `
                                -ValidExitCodes $validExitCodes `
                                -File "$file"
    }

   
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 3) {
  Write-Warning "$key.Count matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $_.DisplayName"}
}



