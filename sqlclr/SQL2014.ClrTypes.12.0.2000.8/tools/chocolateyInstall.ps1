$package = 'SQL2014.ClrTypes'

try {
  $params = @{
    packageName = $package;
    fileType = 'msi';
    silentArgs = '/quiet';
    url = 'https://download.microsoft.com/download/F/E/E/FEE62C90-E5A9-4746-8478-11980609E5C2/ENU/x86/SQLSysClrTypes.msi';
    url64bit = 'https://download.microsoft.com/download/F/E/E/FEE62C90-E5A9-4746-8478-11980609E5C2/ENU/x64/SQLSysClrTypes.msi';
  }

  Install-ChocolateyPackage @params

  # http://forums.iis.net/p/1174672/1968094.aspx
  # it turns out that even on x64, x86 clr types should also be installed
  # or SMO breaks
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