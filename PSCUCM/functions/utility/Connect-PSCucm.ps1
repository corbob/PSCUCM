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
        $EnableException
    )
    Set-PSFConfig -Module PSCUCM -Name Connected -Value $true -Description 'Flag that we''ve "connected" to the server'
    Set-PSFConfig -Module PSCUCM -Name AXLVersion -Value $AXLVersion -Description "AXL Version used by the server (typically the same version as CUCM"
    Set-PSFConfig -Module PSCUCM -Name server -Value $server -Description "Server for PSCUCM to connect to."
    Set-PSFConfig -Module PSCUCM -Name Credential -Value $Credential -Description "Credential for PSCUCM to use to connect to the server."
    $PSDefaultParameterValues['*-PSCucm:EnableException*'] = $EnableException
}