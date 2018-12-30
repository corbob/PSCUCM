function Get-PhoneServicesByDN {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $DN,
        [Parameter(Mandatory=$true)]
        [string]
        $server,
        [Parameter(Mandatory=$true)]
        [pscredential]
        $Credential
    )
    $PhoneByDNSplat = @{
        'DN' = $DN
        'server' = $server
        'Credential' = $Credential
    }
    Get-PhoneByDN @PhoneByDNSplat |
        Select-Xml -XPath '//service' |
        Select-Object -ExpandProperty node
}