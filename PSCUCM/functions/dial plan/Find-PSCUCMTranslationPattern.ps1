function Find-PSCUCMTranslationPattern {
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
            searchCriteria = @{}
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
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
}