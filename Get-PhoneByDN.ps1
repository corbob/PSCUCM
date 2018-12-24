function Get-PhoneByDN {
    [CmdletBinding()]
    param (
        [string]
        $DN,
        [string]
        $server = '10.10.20.1'
    )
    $phoneName = Get-PhoneNameByDN $DN -server $server |
        Select-Xml -XPath '//name' |
        Select-Object -ExpandProperty node |
        Select-Object -ExpandProperty '#text'
    $CUCMAXL = @{
        'server' = $server
        'entity' = 'getPhone'
        'parameters' = @{
            'name' = $phoneName
        }
    }
    Invoke-CUCMAXL @CUCMAXL | Select-Xml -XPath '//phone' | Select-Object -ExpandProperty node
}