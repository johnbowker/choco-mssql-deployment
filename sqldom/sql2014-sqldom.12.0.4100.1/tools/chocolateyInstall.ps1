$package = 'sql2014-sqldom'

try {
  $params = @{
    packageName = $package;
    fileType = 'msi';
    silentArgs = '/quiet';
    url = 'https://download.microsoft.com/download/F/E/E/FEE62C90-E5A9-4746-8478-11980609E5C2/ENU/x86/SqlDom.msi';
    url64bit = 'https://download.microsoft.com/download/F/E/E/FEE62C90-E5A9-4746-8478-11980609E5C2/ENU/x64/SqlDom.msi';
  }

  Install-ChocolateyPackage @params

  # install both x86 and x64 editions of SMO since x64 supports both
  # to install both variants of powershell, both variants of SMO must be present
  $IsSytem32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
    ($Env:PROCESSOR_ARCHITEW6432 -eq $null))
  if (!$IsSytem32Bit)
  {
    $params.url64bit = $params.url
    Install-ChocolateyPackage @params
  }

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}