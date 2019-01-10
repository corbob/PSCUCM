function Set-TranslationPattern {
    <#
    .SYNOPSIS
    Set Translation Patten
    
    .DESCRIPTION
    Set Translation Pattern
    
    .PARAMETER TranslationPattern
    Translation Pattern to set
    
    .PARAMETER RoutePartitionName
    Route Partition that the Translation Pattern is a part of.
    
    .PARAMETER calledPartyTransformationMask
    Transformation Mask
    
    .PARAMETER server
    Server to query
    
    .PARAMETER Credential
    Credential to use for API access
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER OutputXml
    Enable the output of the XML instead of the processing of the entity.
        
    .PARAMETER WhatIf
    What If?
    
    .PARAMETER Confirm
    Confirm...
    
    .EXAMPLE
    An example

    System Up Time: 	0d, 0h, 13m

    #>
    
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TranslationPattern,
        [string]
        $RoutePartitionName,
        [string]
        $calledPartyTransformationMask,
        [Parameter(Mandatory = $true)]
        [string]
        $server,
        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $invokeCucmAxlSplat = @{
        entity          = 'updateTransPattern'
        parameters      = @{
            pattern            = $TranslationPattern
        }
        server          = $server
        Credential      = $Credential
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    if($null -ne $RoutePartitionName) {
        $invokeCucmAxlSplat.parameters.routePartitionName = $RoutePartitionName
    }
    if($null -ne $calledPartyTransformationMask) {
        $invokeCucmAxlSplat.parameters.calledPartyTransformationMask = $calledPartyTransformationMask
    }
    if($PSCmdlet.ShouldProcess($server, "Set Translation Pattern $TranslationPattern")) {
    Invoke-CucmAxl @invokeCucmAxlSplat
    }
}