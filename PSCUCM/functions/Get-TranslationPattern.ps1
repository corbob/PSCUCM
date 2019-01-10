function Get-TranslationPattern {
    <#
    .SYNOPSIS
    Get Translation Patten
    
    .DESCRIPTION
    Get Translation Pattern
    
    .PARAMETER TranslationPattern
    Translation Pattern to get
    
    .PARAMETER RoutePartitionName
    Route Partition that the Translation Pattern is a part of.
    
    .PARAMETER server
    Server to query
    
    .PARAMETER Credential
    Credential to use for API access
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER OutputXml
    Enable the output of the XML instead of the processing of the entity.
    
    .EXAMPLE
    An example

    System Up Time: 	0d, 0h, 13m
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TranslationPattern,
        [string]
        $RoutePartitionName,
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
        entity              = 'getTransPattern'
        parameters = @{
            pattern = $TranslationPattern
            routePartitionName = $RoutePartitionName
        }
        server          = $server
        Credential      = $Credential
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    Invoke-CucmAxl @invokeCucmAxlSplat
    
}