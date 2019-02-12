function Set-PSCUCMTranslationPattern {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TranslationPattern,
        [string]
        $RoutePartitionName = $null,
        [string]
        $CalledPartyTransformationMask = $null,
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
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    if ($RoutePartitionName) {
        $invokeCucmAxlSplat.parameters.routePartitionName = $RoutePartitionName
    }
    if ($calledPartyTransformationMask) {
        $invokeCucmAxlSplat.parameters.calledPartyTransformationMask = $calledPartyTransformationMask
    }
    if ($PSCmdlet.ShouldProcess($server, "Set Translation Pattern $TranslationPattern")) {
        Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
    }
}