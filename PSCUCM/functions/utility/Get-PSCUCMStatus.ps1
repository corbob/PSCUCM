function Get-PSCUCMStatus {
    [CmdletBinding()]
    param ()
    @{
        Connected = Get-PSFConfigValue PSCUCM.Connected
        AXLVersion = Get-PSFConfigValue PSCUCM.AXLVersion
        Server = Get-PSFConfigValue PSCUCM.Server
        SkipCertificateCheck = Get-PSFConfigValue PSCUCM.SkipCertificateCheck
    }
}
