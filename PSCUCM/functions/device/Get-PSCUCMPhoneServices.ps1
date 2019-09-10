function Get-PSCUCMPhoneServices {
    <#
    .SYNOPSIS
    Get the Phone Services for a phone based upon a DN.
    
    .DESCRIPTION
    Get the Phone Services for a phone based upon the DN of the phone. Presumes phones with services don't share the DN... Might fail spectacularly if the DN is shared...
    
    .PARAMETER DN
    Directory Number to look up.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Get-PSCUCMPhoneServices -DN 1001

    Gets the Phone Services for phone with DN 1001.
    #>
    
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '', Justification = "CUCM returns to us all of the services. We can't pick and choose which ones to return.")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $DN,
        [switch]
        $EnableException
    )
    $PhoneByDNSplat = @{
        DN              = $DN
        EnableException = $EnableException
    }
    Get-PSCUCMPhone @PhoneByDNSplat |
        Select-Xml -XPath '//service' |
        Select-Object -ExpandProperty node
}