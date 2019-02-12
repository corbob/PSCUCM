function Get-PSCUCMTranslationPattern {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TranslationPattern,
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