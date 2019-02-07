function Get-PSCUCMPhoneServices {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '', Justification = "CUCM returns to us all of the services. We can't pick and choose which ones to return.")]
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