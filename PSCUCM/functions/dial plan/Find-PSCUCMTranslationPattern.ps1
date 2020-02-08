function Find-PSCUCMTranslationPattern {
    <#
    .SYNOPSIS
    Find Translation Patterns within CUCM
    
    .DESCRIPTION
    Find Translation Patterns within CUCM
    
    .PARAMETER Pattern
    Pattern to possibly search for
    
    .PARAMETER Description
    Description to possibly search for
    
    .PARAMETER RoutePartitionName
    Route Partition to possibly search for
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Find-PSCUCMTranslationPattern -Pattern 1234

    Returns the information for Translation Pattern 1234.
    
    #>
    [CmdletBinding()]
    param (
        [string]
        $Pattern,
        [string]
        $Description,
        [string]
        $RoutePartitionName,
        [switch]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'listTransPattern'
        parameters      = @{
            searchCriteria = @{ }
            returnedTags   = @{
                pattern                        = ''
                description                    = ''
                usage                          = ''
                routePartitionName             = ''
                blockEnable                    = ''
                calledPartyTransformationMask  = ''
                callingPartyTransformationMask = ''
                useCallingPartyPhoneMask       = ''
                callingPartyPrefixDigits       = ''
                dialPlanName                   = ''
                digitDiscardInstructionName    = ''
                patternUrgency                 = ''
                prefixDigitsOut                = ''
                routeFilterName                = ''
                callingLinePresentationBit     = ''
                callingNamePresentationBit     = ''
                connectedLinePresentationBit   = ''
                connectedNamePresentationBit   = ''
                patternPrecedence              = ''
                provideOutsideDialtone         = ''
                callingPartyNumberingPlan      = ''
                callingPartyNumberType         = ''
                calledPartyNumberingPlan       = ''
                calledPartyNumberType          = ''
                callingSearchSpaceName         = ''
                resourcePriorityNamespaceName  = ''
                routeNextHopByCgpn             = ''
                routeClass                     = ''
                callInterceptProfileName       = ''
                releaseClause                  = ''
                useOriginatorCss               = ''
                dontWaitForIDTOnSubsequentHops = ''
                isEmergencyServiceNumber       = ''
            }
        }
        EnableException = $EnableException
    }
    if (![string]::IsNullOrEmpty($Pattern)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.pattern = $Pattern
    }
    if (![string]::IsNullOrEmpty($Description)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.description = $Description
    }
    if (![string]::IsNullOrEmpty($RoutePartitionName)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.routePartitionName = $RoutePartitionName
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | Select-Xml -XPath '//transPattern' | Select-Object -ExpandProperty node
}