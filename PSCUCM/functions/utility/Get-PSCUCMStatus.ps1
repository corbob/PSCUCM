function Get-PSCUCMStatus {
    <#
    .SYNOPSIS
    Get the status of the current CUCM Connection
    
    .DESCRIPTION
    Get the status of the current CUCM Connection. Does *not* return the credential.
    
    .EXAMPLE
    Get-PSCUCMStatus

    

    Name                           Value
    ----                           -----
    Server
    SkipCertificateCheck
    AXLVersion
    Connected                      False
    #>
    [CmdletBinding()]
    param ()
    @{
        Connected = Get-PSFConfigValue PSCUCM.Connected
        AXLVersion = Get-PSFConfigValue PSCUCM.AXLVersion
        Server = Get-PSFConfigValue PSCUCM.Server
        SkipCertificateCheck = Get-PSFConfigValue PSCUCM.SkipCertificateCheck
    }
}
