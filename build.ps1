$BuildFolder = ".\build"
function New-BuildFolder()
{
    if(!(Test-Path -Path $BuildFolder))
    {
        New-Item -ItemType Directory -Path $BuildFolder
    }
}
function Remove-Packages()
{
    Write-Output "Cleaning..."
    Remove-Item "$BuildFolder\*.nupkg" | Where { ! $_.PSIsContainer }
    Write-Output "Cleaned"
}

function New-ChocoPackage($PackageName)
{

    Write-Verbose "Starting $PackageName package build"

    $Command = "choco pack $PSScriptRoot\$PackageName\$PackageName.nuspec -OutputDirectory $BuildFolder"
    Invoke-Expression $Command

    $BuildResult = $false

    if($LASTEXITCODE -ne 0)
    {
        Write-Error 'Package Build Failed'
    }
    else
    {
        $BuildResult = $true
    }
    return $BuildResult
}

function Main()
{
    New-BuildFolder
    Remove-Packages

    $Packages = (
        "SQL2014.ClrTypes",
        "sql2014-dacframework",
        "sql2014-sqldom",
        "sql2016-dacframework",
        "sql2016-clrtypes",
        "sql2016-smo"
        )

    foreach($Package in $Packages)
    {
        $Result = (New-ChocoPackage -PackageName $Package)

        Write-Output $Result

        if($Result -eq $false)
        {
            Exit 1
        }
    }
}

Main
