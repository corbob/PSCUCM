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
    if ([string]::IsNullOrEmpty($name)) {
        $name = '%'
    }
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
                members                   = @{
                    member = @{
                        lineSelectionOrder = $null
                        directoryNumber    = @{
                            pattern            = $null
                            routePartitionName = $null
                        }
                    }
                }
                name                      = $name
                autoLogOffHunt            = $null
            }
        }
        EnableException = $EnableException
    }
    $invokeCucmAxlSplat.parameters.searchCriteria.name = $name
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | Select-Xml -XPath '//lineGroup' | Select-Object -ExpandProperty Node
}
