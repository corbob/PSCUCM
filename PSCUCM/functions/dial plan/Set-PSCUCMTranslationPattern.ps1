function Set-PSCUCMTranslationPattern {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TranslationPattern,
        [string]
        $RoutePartitionName,
        [string]
        $CalledPartyTransformationMask,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $invokeCucmAxlSplat = @{
        entity          = 'updateTransPattern'
        parameters      = @{
            pattern = $TranslationPattern
        }
        AXLVersion      = Get-PSFConfigValue -FullName pscucm.axlversion
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    if ($null -ne $RoutePartitionName) {
        $invokeCucmAxlSplat.parameters.routePartitionName = $RoutePartitionName
    }
    if ($null -ne $calledPartyTransformationMask) {
        $invokeCucmAxlSplat.parameters.calledPartyTransformationMask = $calledPartyTransformationMask
    }
    if ($PSCmdlet.ShouldProcess($server, "Set Translation Pattern $TranslationPattern")) {
        Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
    }
}