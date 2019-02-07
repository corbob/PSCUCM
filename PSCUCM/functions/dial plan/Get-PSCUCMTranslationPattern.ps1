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
        AXLVersion      = Get-PSFConfigValue -FullName pscucm.axlversion
        EnableException = $EnableException
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
}