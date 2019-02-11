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