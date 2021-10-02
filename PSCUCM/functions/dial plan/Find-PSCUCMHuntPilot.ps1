function Find-PSCUCMHuntPilot {
    <#
    .SYNOPSIS
    Find Hunt Pilots
    
    .DESCRIPTION
    Find Hunt Pilots within CUCM Environment
    
    .PARAMETER pattern
    Pattern to search for
    
    .PARAMETER Description
    Description to search for.
    
    .PARAMETER RoutePartitionName
    Route Partition to search within.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Find-PSCUCMHuntPilot -Description %

    Search for all Hunt Pilots without Route Partion
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $pattern,
        [Parameter()]
        [string]
        $Description,
        [Parameter()]
        [string]
        $RoutePartitionName,
        [switch]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'listHuntPilot'
        parameters      = @{
            searchCriteria = @{

            }
            returnedTags   = @{
                pattern                        = $null
                description                    = $null
                usage                          = $null
                routePartitionName             = $null
                blockEnable                    = $null
                calledPartyTransformationMask  = $null
                callingPartyTransformationMask = $null
                useCallingPartyPhoneMask       = $null
                callingPartyPrefixDigits       = $null
                dialPlanName                   = $null
                digitDiscardInstructionName    = $null
                patternUrgency                 = $null
                prefixDigitsOut                = $null
                routeFilterName                = $null
                callingLinePresentationBit     = $null
                callingNamePresentationBit     = $null
                connectedLinePresentationBit   = $null
                connectedNamePresentationBit   = $null
                patternPrecedence              = $null
                provideOutsideDialtone         = $null
                callingPartyNumberingPlan      = $null
                callingPartyNumberType         = $null
                calledPartyNumberingPlan       = $null
                calledPartyNumberType          = $null
                huntListName                   = $null
                parkMonForwardNoRetrieve       = @{
                    usePersonalPreferences = $null
                    destination            = $null
                    callingSearchSpaceName = $null
                }
                alertingName                   = $null
                asciiAlertingName              = $null
                aarNeighborhoodName            = $null
                forwardHuntNoAnswer            = @{
                    usePersonalPreferences = $null
                    destination            = $null
                    callingSearchSpaceName = $null
                }
                forwardHuntBusy                = @{
                    usePersonalPreferences = $null
                    destination            = $null
                    callingSearchSpaceName = $null
                }
                callPickupGroupName            = $null
                maxHuntduration                = $null
                releaseClause                  = $null
                displayConnectedNumber         = $null
                queueCalls                     = @{
                    maxCallersInQueue                = $null
                    queueFullDestination             = $null
                    callingSearchSpacePilotQueueFull = $null
                    maxWaitTimeInQueue               = $null
                    maxWaitTimeDestination           = $null
                    callingSearchSpaceMaxWaitTime    = $null
                    noAgentDestination               = $null
                    callingSearchSpaceNoAgent        = $null
                    networkHoldMohAudioSourceID      = $null
                }
            }
        }
        EnableException = $EnableException
    }
    if ($pattern) {
        $invokeCucmAxlSplat.parameters.searchCriteria.pattern = $pattern
    }
    if (![string]::IsNullOrEmpty($Description)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.description = $Description
    }
    if (![string]::IsNullOrEmpty($RoutePartitionName)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.routePartitionName = $RoutePartitionNamepattern
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | Select-Xml -XPath '//huntPilot' | Select-Object -ExpandProperty Node
}
