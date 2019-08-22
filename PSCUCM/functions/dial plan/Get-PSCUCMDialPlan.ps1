function Get-PSCUCMRoutePlan {
    [CmdletBinding()]
    param (
        [string]
        $RoutePartitionName,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $invokeCucmAxlSplat = @{
        entity          = 'getTransPattern'
        parameters      = @{
            pattern            = $TranslationPattern
            routePartitionName = $RoutePartitionName
        }
        OutputXml       = $OutputXml
        EnableException = $EnableException
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
}
