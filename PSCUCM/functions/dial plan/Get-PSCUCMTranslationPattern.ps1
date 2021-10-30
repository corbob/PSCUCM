function Get-PSCUCMTranslationPattern {
    <#
    .SYNOPSIS
    Get the Translation Pattern
    
    .DESCRIPTION
    Get the Translation Pattern
    
    .PARAMETER TranslationPattern
    Translation Pattern to look up.
    
    .PARAMETER RoutePartitionName
    Route Partition that houses the Translation Pattern.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Get-PSCUCMTranslationPattern -TranslationPattern 1234 -RoutePartitonName default-rp

    Gets the Translation Pattern for 1234.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TranslationPattern,
        [Parameter(Mandatory = $true)]
        [string]
        $RoutePartitionName,
        [switch]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'getTransPattern'
        parameters      = @{
            pattern            = $TranslationPattern
            routePartitionName = $RoutePartitionName
        }
        EnableException = $EnableException
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | Select-Xml -XPath '//transPattern' | Select-Object -ExpandProperty Node
}
