function Find-PSCUCMLine {
    <#
    .SYNOPSIS
    Find lines within CUCM
    
    .DESCRIPTION
    Find lines within CUCM that match the criteria
    
    .PARAMETER Pattern
    Pattern to search
    
    .PARAMETER Description
    Description to search
    
    .PARAMETER Usage
    Usage to search (Your guess is as good as mine...)
    
    .PARAMETER RoutePartitionName
    RoutePartitionName to search
    
    .PARAMETER skip
    Number of lines to skip.
    
    .PARAMETER first
    Number of lines to return.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Find-PSCUCMLine -Line %

    Finds all lines within CUCM
    
    .NOTES
    Uses SQL Wildcards. So %
    #>
    
    [CmdletBinding()]
    param (
        [string]
        $Pattern,
        [string]
        $Description,
        [string]
        $Usage,
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
        Entity          = 'listLine'
        Parameters      = @{
            searchCriteria = @{}
            returnedTags   = @{
                pattern                              = ''
                description                          = ''
                usage                                = ''
                routePartitionName                   = ''
                aarNeighborhoodName                  = ''
                aarDestinationMask                   = ''
                aarKeepCallHistory                   = ''
                aarVoiceMailEnabled                  = ''
                callPickupGroupName                  = ''
                autoAnswer                           = ''
                networkHoldMohAudioSourceId          = ''
                userHoldMohAudioSourceId             = ''
                alertingName                         = ''
                asciiAlertingName                    = ''
                presenceGroupName                    = ''
                shareLineAppearanceCssName           = ''
                voiceMailProfileName                 = ''
                patternPrecedence                    = ''
                releaseClause                        = ''
                hrDuration                           = ''
                hrInterval                           = ''
                cfaCssPolicy                         = ''
                defaultActivatedDeviceName           = ''
                parkMonForwardNoRetrieveDn           = ''
                parkMonForwardNoRetrieveIntDn        = ''
                parkMonForwardNoRetrieveVmEnabled    = ''
                parkMonForwardNoRetrieveIntVmEnabled = ''
                parkMonForwardNoRetrieveCssName      = ''
                parkMonForwardNoRetrieveIntCssName   = ''
                parkMonReversionTimer                = ''
                partyEntranceTone                    = ''
                allowCtiControlFlag                  = ''
                rejectAnonymousCall                  = ''
                confidentialAccess                   = @{
                    confidentialAccessMode  = ''
                    confidentialAccessLevel = ''
                }
                externalCallControlProfile           = ''
                enterpriseAltNum                     = @{
                    numMask                = ''
                    isUrgent               = ''
                    addLocalRoutePartition = ''
                    routePartition         = ''
                    advertiseGloballyIls   = ''
                }
                e164AltNum                           = @{
                    numMask                = ''
                    isUrgent               = ''
                    addLocalRoutePartition = ''
                    routePartition         = ''
                    advertiseGloballyIls   = ''
                }
                pstnFailover                         = ''
                associatedDevices                    = @{
                    device = ''
                }
            }
        }
        EnableException = $EnableException
    }
    if(![string]::IsNullOrEmpty($Pattern)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('pattern', $pattern)
    }
    if(![string]::IsNullOrEmpty($description)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('description', $description)
    }
    if(![string]::IsNullOrEmpty($usage)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('usage', $usage)
    }
    if(![string]::IsNullOrEmpty($routePartitionName)) {
        $CucmAxlSplat.Parameters.searchCriteria.Add('routePartitionName', $routePartitionName)
    }
    if($skip) {
        $CucmAxlSplat.Parameters.Add('skip', $skip)
    }
    if($first) {
        $CucmAxlSplat.Parameters.Add('first', $first)
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat | Select-Xml -XPath '//line' | Select-Object -ExpandProperty node
}