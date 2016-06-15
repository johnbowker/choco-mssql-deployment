$ErrorActionPreference = 'Stop';


$packageName= 'sql2014-dacframework'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/B/8/C/B8C77167-AF51-4202-9AFD-A147A88F1D5B/en-EN/x86/DACFramework.msi'
$url64      = 'https://download.microsoft.com/download/B/8/C/B8C77167-AF51-4202-9AFD-A147A88F1D5B/en-EN/x64/DACFramework.msi'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE_MSI_OR_MSU'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'sql2014-dacframework*'
  checksum      = ''
  checksumType  = 'md5'
  checksum64    = ''
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
