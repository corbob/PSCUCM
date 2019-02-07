function Get-PSCUCMPhone {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $DN,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $phoneNameByDNSplat = @{
        DN              = $DN
        OutputXml       = $OutputXml
        EnableException = $EnableException
    }
    $phoneName = Get-PSCUCMPhoneName @phoneNameByDNSplat |
        Select-Xml -XPath '//name' |
        Select-Object -ExpandProperty node |
        Select-Object -ExpandProperty '#text'
    $CucmAxlSplat = @{
        'server'     = $server
        'entity'     = 'getPhone'
        'parameters' = @{
            'name' = $phoneName
        }
        'Credential' = $Credential
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat | Select-Xml -XPath '//phone' | Select-Object -ExpandProperty node
}