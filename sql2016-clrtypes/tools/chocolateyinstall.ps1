
$ErrorActionPreference = 'Stop';


$packageName= 'sql2016-clrtypes'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.microsoft.com/download/E/4/1/E41A6614-9FB0-4675-8A97-08F8B1A1827D/EN/SQL13/x86/SQLSysClrTypes.msi'
$url64      = 'http://download.microsoft.com/download/E/4/1/E41A6614-9FB0-4675-8A97-08F8B1A1827D/EN/SQL13/amd64/SQLSysClrTypes.msi'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'Microsoft System CLR Types for SQL Server 2016*'
}

# If we are on a x64 system we need to install the x86 package as well.
$IsSystem32Bit = Get-ProcessorBits -Compare 32
if (!$IsSystem32Bit) {
  Write-Host 'Installing 32bit version with 64bit.'
  $packageArgs.url64bit = $params.url
  Install-ChocolateyPackage @packageArgs
  
  $packageArgs.url64bit = $params.url64bit
  Install-ChocolateyPackage @packageArgs
}
else {
  Write-Host 'Installing 32bit version.'
  Install-ChocolateyPackage @packageArgs
}


