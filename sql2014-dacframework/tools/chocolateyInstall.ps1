$package = 'sql2014-dacframework'

try {
  $params = @{
    packageName = $package;
    fileType = 'msi';
    silentArgs = '/quiet';
    url = 'https://download.microsoft.com/download/B/8/C/B8C77167-AF51-4202-9AFD-A147A88F1D5B/en-EN/x86/DACFramework.msi';  
    url64bit = 'https://download.microsoft.com/download/B/8/C/B8C77167-AF51-4202-9AFD-A147A88F1D5B/en-EN/x64/DACFramework.msi';
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
