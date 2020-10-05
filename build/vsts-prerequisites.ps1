$modules = @(
    @{
        name       = "Pester"
        maxVersion = "4.99"
    }
    @{
        name       = "PSFramework"
        maxVersion = "999.99"
    }
    @{
        name       = "PSScriptAnalyzer"
        maxVersion = "999.99"
    }
)

foreach ($module in $modules) {
    Write-Host "Installing $($module.name)" -ForegroundColor Cyan
    Install-Module $module.name -Force -SkipPublisherCheck -MaximumVersion $module.maxVersion
    Import-Module $module.name -Force -PassThru
}
