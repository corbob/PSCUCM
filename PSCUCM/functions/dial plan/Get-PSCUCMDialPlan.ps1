function Get-PSCUCMRoutePlan {
    [CmdletBinding()]
    param (
        [string]
        $RoutePartitionName,
        [switch]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'getTransPattern'
        parameters      = @{
            pattern            = $TranslationPattern
            routePartitionName = $RoutePartitionName
        }
        EnableException = $EnableException
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
}
