function Connect-PSCucm {
    <#
    .SYNOPSIS
    "Connect" to CUCM Server
    
    .DESCRIPTION
    "Connect" to a CUCM Server using the supplied values.
    
    .PARAMETER AXLVersion
    AXL Version for the Server to connect to. Typically same version as CUCM itself.
    
    .PARAMETER server
    Server to connect to.
    
    .PARAMETER Credential
    Credential Object for the Application User that has the appropriate AXL permissions.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER SkipCertificateCheck
    Skip the check of the certificate. Needed in test environments, and environments without "valid" signed certificates.
    
    .PARAMETER PersistSettings
    Persist the settings beyond the current session.
    
    .EXAMPLE
    Connect-PSCucm -AXLVersion 11.5 -server cucm.example.com -Credential $AXLCredential

    It connects to CUCM Server cucm.example.com
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $AXLVersion,
        [Parameter(Mandatory = $true)]
        [string]
        $server,
        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential,
        [switch]
        $EnableException,
        [switch]
        $SkipCertificateCheck,
        [switch]
        $PersistSettings
    )
    Set-PSFConfig -Module PSCUCM -Name Connected -Value $true
    Set-PSFConfig -Module PSCUCM -Name AXLVersion -Value $AXLVersion
    Set-PSFConfig -Module PSCUCM -Name Server -Value $Server
    Set-PSFConfig -Module PSCUCM -Name Credential -Value $Credential
    Set-PSFConfig -Module PSCUCM -Name SkipCertificateCheck -Value $SkipCertificateCheck
    $Global:PSDefaultParameterValues['*-PSCucm*:EnableException'] = $EnableException
    if ($PersistSettings) {
        Register-PSFConfig -FullName pscucm.axlversion
        Register-PSFConfig -FullName pscucm.server
        Register-PSFConfig -FullName pscucm.credential
        Register-PSFConfig -FullName pscucm.$SkipCertificateCheck
    }
}