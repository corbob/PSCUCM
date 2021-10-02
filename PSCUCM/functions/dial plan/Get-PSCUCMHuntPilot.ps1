function Get-PSCUCMHuntPilot {
    <#
    .SYNOPSIS
    Get Hunt Pilot
    
    .DESCRIPTION
    Get Hunt Pilot
    
    .PARAMETER uuid
    UUID of Hunt Pilot
    
    .PARAMETER pattern
    Pattern of Hunt Pilot
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Get-PSCUCMHuntPilot 1234

    Get Hunt Pilot for pattern 1234
    #>
    [CmdletBinding(DefaultParameterSetName = "pattern")]
    param (
        [Parameter(ParameterSetName = 'uuid', Mandatory, Position = 0)]
        [string]
        $uuid,
        [Parameter(ParameterSetName = 'pattern', Mandatory, Position = 0)]
        [int]
        $pattern,
        [switch]
        [Parameter()]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'getHuntPilot'
        parameters      = @{
        }
        EnableException = $EnableException
    }
    if($PSCmdlet.ParameterSetName -eq 'pattern') {
        $invokeCucmAxlSplat.parameters.pattern = $pattern
    }
    if($PSCmdlet.ParameterSetName -eq 'uuid') {
        $invokeCucmAxlSplat.parameters.uuid = $uuid
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | Select-Xml -XPath '//huntPilot' | Select-Object -ExpandProperty Node
}
