<#
This is an example configuration file

By default, it is enough to have a single one of them,
however if you have enough configuration settings to justify having multiple copies of it,
feel totally free to split them into multiple files.
#>

<#
# Example Configuration
Set-PSFConfig -Module 'PSCUCM' -Name 'Example.Setting' -Value 10 -Initialize -Validation 'integer' -Handler { } -Description "Example configuration setting. Your module can then use the setting using 'Get-PSFConfigValue'"
#>

Set-PSFConfig -Module 'PSCUCM' -Name 'Import.DoDotSource' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be dotsourced on import. By default, the files of this module are read as string value and invoked, which is faster but worse on debugging."
Set-PSFConfig -Module 'PSCUCM' -Name 'Import.IndividualFiles' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be imported individually. During the module build, all module code is compiled into few files, which are imported instead by default. Loading the compiled versions is faster, using the individual files is easier for debugging and testing out adjustments."
Set-PSFConfig -Module 'PSCUCM' -Name 'Connected' -Value $false -Description 'Flag that we''ve "connected" to the server' -Initialize
Set-PSFConfig -Module 'PSCUCM' -Name 'AXLVersion' -Value $null -Description "AXL Version used by the server (typically the same version as CUCM" -Initialize
Set-PSFConfig -Module 'PSCUCM' -Name 'Server' -Value $null -Description "Server for PSCUCM to connect to." -Initialize
Set-PSFConfig -Module 'PSCUCM' -Name 'Credential' -Value $null -Description "Credential for PSCUCM to use to connect to the server." -Initialize
Set-PSFConfig -Module 'PSCUCM' -Name 'SkipCertificateCheck' -Value $null -Description "Should PSCUCM Skip the certificate check (If you use a self signed you want to set this)" -Initialize