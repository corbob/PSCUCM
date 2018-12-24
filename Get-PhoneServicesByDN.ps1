function Get-PhoneServicesByDN {
    [CmdletBinding()]
    param (
        [string]
        $DN,
        [string]
        $server = '10.10.20.1'
    )
    Get-PhoneByDN $DN -server $server |
        Select-Xml -XPath '//service' |
        Select-Object -ExpandProperty node
}