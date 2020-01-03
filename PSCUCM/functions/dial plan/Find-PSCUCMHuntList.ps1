function Find-PSCUCMHuntList {
    <#
    .SYNOPSIS
    Find Hunt Lists in CUCM
    
    .DESCRIPTION
    Find Hunt Lists in your CUCM environment.
    
    .PARAMETER name
    Name of Hunt List
    
    .PARAMETER Description
    Description of Hunt List
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Find-PSCUCMHuntList -name %

    Returns all Hunt Lists within CUCM
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $name,
        [Parameter()]
        [string]
        $Description,
        [switch]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'listHuntList'
        parameters      = @{
            searchCriteria = @{

            }
            returnedTags   = @{
                description          = $null
                callManagerGroupName = $null
                routeListEnabled     = $null
                voiceMailUsage       = $null
                name                 = $null
            }
        }
        EnableException = $EnableException
    }
    if (![string]::IsNullOrEmpty($name)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.name = $name
    }
    if (![string]::IsNullOrEmpty($Description)) {
        $invokeCucmAxlSplat.parameters.searchCriteria.description = $Description
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | select-Object -ExpandProperty huntList
}