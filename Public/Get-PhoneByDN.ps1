function Get-PhoneByDN {
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
    $phoneNameByDNSplat = @{
        'DN' = $DN
        'server' = $server
        'Credential' = $Credential
    }
    $phoneName = Get-PhoneNameByDN @phoneNameByDNSplat |
        Select-Xml -XPath '//name' |
        Select-Object -ExpandProperty node |
        Select-Object -ExpandProperty '#text'
    $CUCMAXL = @{
        'server' = $server
        'entity' = 'getPhone'
        'parameters' = @{
            'name' = $phoneName
        }
        'Credential' = $Credential
    }
    Invoke-CUCMAXL @CUCMAXL | Select-Xml -XPath '//phone' | Select-Object -ExpandProperty node
}