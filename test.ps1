function Install-ChocoPackage($PackageName, $PackageSourceDirectory)
{
    $Command = "choco install $PackageName -source $PackageSourceDirectory --force -y"
    Invoke-Expression $Command
}

function UnInstall-ChocoPackage($PackageName)
{
    $Command = "choco uninstall $PackageName --force -y"
    Invoke-Expression $Command
}

function Test-CLRTypes()
{
    $PackageName = "sql2014-dacframework"
    Install-ChocoPackage -PackageName $PackageName -PackageSourceDirectory (Get-Item -Path ".\" -Verbose).FullName
    UnInstall-ChocoPackage -PackageName $PackageName
}

function Test-SQLDom()
{
    $PackageName = "sql2014-sqldom"
    Install-ChocoPackage -PackageName $PackageName -PackageSourceDirectory (Get-Item -Path ".\" -Verbose).FullName
    UnInstall-ChocoPackage -PackageName $PackageName
}

function Test-DACFramework()
{
    $PackageName = "SQL2014.ClrTypes"
    Install-ChocoPackage -PackageName $PackageName -PackageSourceDirectory (Get-Item -Path ".\" -Verbose).FullName
    UnInstall-ChocoPackage -PackageName $PackageName
}


Invoke-Expression "$PSScriptRoot\build.ps1"

Test-CLRTypes
Test-SQLDom
Test-DACFramework
