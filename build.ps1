
function Build-ChocoPackage($PackageName)
{

    Write-Verbose "Starting $PackageName package build"

    $Command = "choco pack $PSScriptRoot\$PackageName\$PackageName.nuspec"
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
    $Packages = (
        "SQL2014.ClrTypes", 
        "sql2014-dacframework", 
        "sql2014-sqldom"
        )

    foreach($Package in $Packages)
    {
        $Result = (Build-ChocoPackage -PackageName $Package)

        Write-Output $Result

        if($Result -eq $false)
        {
            Exit 1
        }
    }
}

Main