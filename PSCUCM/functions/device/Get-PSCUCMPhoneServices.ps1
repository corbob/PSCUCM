function Get-PSCUCMPhoneServices {
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
    $PhoneByDNSplat = @{
        DN              = $DN
        OutputXml       = $OutputXml
        EnableException = $EnableException
    }
    Get-PSCUCMPhone @PhoneByDNSplat |
        Select-Xml -XPath '//service' |
        Select-Object -ExpandProperty node
}