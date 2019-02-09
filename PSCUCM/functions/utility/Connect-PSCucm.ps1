function Connect-PSCucm {

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
    Set-PSFConfig -Module PSCUCM -Name Connected -Value $true -Description 'Flag that we''ve "connected" to the server'
    Set-PSFConfig -Module PSCUCM -Name AXLVersion -Value $AXLVersion -Description "AXL Version used by the server (typically the same version as CUCM"
    Set-PSFConfig -Module PSCUCM -Name Server -Value $Server -Description "Server for PSCUCM to connect to."
    Set-PSFConfig -Module PSCUCM -Name Credential -Value $Credential -Description "Credential for PSCUCM to use to connect to the server."
    Set-PSFConfig -Module PSCUCM -Name SkipCertificateCheck -Value $SkipCertificateCheck -Description "Should PSCUCM Skip the certificate check (If you use a self signed you want to set this)"
    $PSDefaultParameterValues['*-PSCucm:EnableException*'] = $EnableException
    if($PersistSettings) {
        Register-PSFConfig -FullName pscucm.axlversion
        Register-PSFConfig -FullName pscucm.server
        Register-PSFConfig -FullName pscucm.credential
        Register-PSFConfig -FullName pscucm.$SkipCertificateCheck
    }
}