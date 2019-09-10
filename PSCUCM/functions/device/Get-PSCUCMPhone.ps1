function Get-PSCUCMPhone {
    <#
    .SYNOPSIS
    Get a single phone in CUCM
    
    .DESCRIPTION
    Get a single phone in CUCM based upon the Directory Number
    
    .PARAMETER DN
    Directory Number to look up.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Get-PSCUCMPhone -DN 1001

    Returns the phone with DN 1001.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $DN,
        [switch]
        $EnableException
    )
    $phoneNameByDNSplat = @{
        DN              = $DN
        EnableException = $EnableException
    }
    $phoneName = Get-PSCUCMPhoneName @phoneNameByDNSplat |
        Select-Xml -XPath '//name' |
        Select-Object -ExpandProperty node |
        Select-Object -ExpandProperty '#text'
    $CucmAxlSplat = @{
        'entity'     = 'getPhone'
        'parameters' = @{
            'name' = $phoneName
        }
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat | Select-Xml -XPath '//phone' | Select-Object -ExpandProperty node
}