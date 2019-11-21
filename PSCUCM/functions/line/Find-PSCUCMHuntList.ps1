function Find-PSCUCMHuntPilot {
    
    [CmdletBinding()]
    param (
        [string]
        $Pattern,
        [string]
        $Description,
        [string]
        $RoutePartitionName,
        [int]
        $skip,
        [int]
        $first,
        [switch]
        $EnableException
    )
    $CucmAxlSplat = @{
        Entity          = 'listHuntList'
        Parameters      = @{
            searchCriteria = @{ }
            returnedTags   = @{
                aarNeighborhoodName            = ''
                alertingName                   = ''
                asciiAlertingName              = ''
                blockEnable                    = ''
                calledPartyNumberingPlan       = ''
                calledPartyNumberType          = ''
                calledPartyTransformationMask  = ''
                callingLinePresentationBit     = ''
                callingNamePresentationBit     = ''
                callingPartyNumberingPlan      = ''
                callingPartyNumberType         = ''
                callingPartyPrefixDigits       = ''
                callingPartyTransformationMask = ''
                callPickupGroupName            = ''
                connectedLinePresentationBit   = ''
                connectedNamePresentationBit   = ''
                description                    = ''
                dialPlanName                   = ''
                digitDiscardInstructionName    = ''
                displayConnectedNumber         = ''
                forwardHuntBusy                = ''
                forwardHuntNoAnswer            = ''
                huntListName                   = ''
                maxHuntduration                = ''
                parkMonForwardNoRetrieve       = ''
                pattern                        = ''
                patternPrecedence              = ''
                patternUrgency                 = ''
                prefixDigitsOut                = ''
                provideOutsideDialtone         = ''
                queueCalls                     = ''
                releaseClause                  = ''
                routeFilterName                = ''
                routePartitionName             = ''
                usage                          = ''
                useCallingPartyPhoneMask       = ''
            }
        }
        EnableException = $EnableException
    }
    if (![string]::IsNullOrEmpty($Pattern)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('pattern', $pattern)
    }
    if (![string]::IsNullOrEmpty($description)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('description', $description)
    }
    if (![string]::IsNullOrEmpty($usage)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('usage', $usage)
    }
    if (![string]::IsNullOrEmpty($routePartitionName)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('routePartitionName', $routePartitionName)
    }
    if ($skip) {
        $CucmAxlSplat.Parameters.Add('skip', $skip)
    }
    if ($first) {
        $CucmAxlSplat.Parameters.Add('first', $first)
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat | Select-Xml -XPath '//huntList' | Select-Object -ExpandProperty node
}