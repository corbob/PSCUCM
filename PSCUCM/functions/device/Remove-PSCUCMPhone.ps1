function Remove-PSCUCMPhone {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [Parameter(ParameterSetName = "Name", Mandatory)]
        [string]
        $Name,
        [Parameter(ParameterSetName = "UUID", Mandatory)]
        [string]
        $UUID,
        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "UUID")]
        [switch]
        $EnableException
    )
    $cucmDeets = Get-PSCUCMStatus
    $invokeCucmAxlSplat = @{
        entity          = 'removePhone'
        EnableException = $EnableException
    }
    if ($PSCmdlet.ParameterSetName -eq 'Name') {
        $invokeCucmAxlSplat.parameters = @{
            name = $name
        }
    }
    if ($PSCmdlet.ParameterSetName -eq 'UUID') {
        $invokeCucmAxlSplat.parameters = @{
            uuid = $UUID
        }
    }
    if ($PSCmdlet.ShouldProcess($cucmDeets.Server, "Remove Phone $Name$UUID")) {
            Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
        }
    }