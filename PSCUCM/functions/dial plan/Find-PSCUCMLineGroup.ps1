function Find-PSCUCMLineGroup {
    <#
    .SYNOPSIS
    Find Line Groups
    
    .DESCRIPTION
    Find Line Groups within CUCM Environment
    
    .PARAMETER name
    Name of Line Group to search for.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Find-PSCUCMLineGroup %

    Find all Line Groups
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $name,
        [switch]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'listLineGroup'
        parameters      = @{
            searchCriteria = @{

            }
            returnedTags   = @{
                distributionAlgorithm     = $null
                rnaReversionTimeOut       = $null
                huntAlgorithmNoAnswer     = $null
                huntAlgorithmBusy         = $null
                huntAlgorithmNotAvailable = $null
                embers                    = @{
                    ember = @{
                        lineSelectionOrder = $null
                        irectoryNumber     = @{
                            pattern            = $null
                            routePartitionName = $null
                        }
                    }
                }
                name                      = $null
                autoLogOffHunt            = $null
            }
        }
        EnableException = $EnableException
    }
    if (![string]::IsNullOrEmpty($name)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.name = $name
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | select-Object -ExpandProperty lineGroup
}