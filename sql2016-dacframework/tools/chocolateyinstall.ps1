
$ErrorActionPreference = 'Stop';


$packageName= 'sql2016-dacframework'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/3/9/1/39135819-06B1-4A07-B9B0-02397E2F5D0F/EN/x86/DacFramework.msi'
$url64      = 'https://download.microsoft.com/download/3/9/1/39135819-06B1-4A07-B9B0-02397E2F5D0F/EN/x64/DacFramework.msi'

$arch = Get-ProcessorBits
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = "Microsoft SQL Server Data-Tier Application Framework (x$($arch))"
}

Install-ChocolateyPackage @packageArgs
