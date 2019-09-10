function Set-PSCUCMTranslationPattern {
        <#
    .SYNOPSIS
    Set the Translation Pattern
    
    .DESCRIPTION
    Set the Translation Pattern
    
    .PARAMETER TranslationPattern
    Translation Pattern to set.
    
    .PARAMETER RoutePartitionName
    Route Partition that houses the Translation Pattern.

    .PARAMETER CalledPartyTransformationMask
    The transformation mask to apply to the translation pattern.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.

    .PARAMETER WhatIf
    What If?
    
    .PARAMETER Confirm
    Confirm...
    
    .EXAMPLE
    Get-PSCUCMTranslationPattern -TranslationPattern 1234 -RoutePartitonName default-rp

    Gets the Translation Pattern for 1234.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TranslationPattern,
        [string]
        $RoutePartitionName = $null,
        [string]
        $CalledPartyTransformationMask = $null,
        [switch]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'updateTransPattern'
        parameters      = @{
            pattern = $TranslationPattern
        }
        EnableException = $EnableException
    }
    if ($RoutePartitionName) {
        $invokeCucmAxlSplat.parameters.routePartitionName = $RoutePartitionName
    }
    if ($calledPartyTransformationMask) {
        $invokeCucmAxlSplat.parameters.calledPartyTransformationMask = $calledPartyTransformationMask
    }
    if ($PSCmdlet.ShouldProcess($server, "Set Translation Pattern $TranslationPattern")) {
        Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
    }
}