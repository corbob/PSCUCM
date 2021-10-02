function Get-PSCUCMLineGroup {
    <#
    .SYNOPSIS
    Get Line Group
    
    .DESCRIPTION
    Get Line Group
    
    .PARAMETER uuid
    UUID of Line Group
    
    .PARAMETER name
    Name of Line Group
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Get-PSCUCMLineGroup -name 'Line Group 3'

    Get 'Line Group 3' information.
    #>
    [CmdletBinding(DefaultParameterSetName = "name")]
    param (
        [Parameter(ParameterSetName = 'uuid', Mandatory, Position = 0)]
        [string]
        $uuid,
        [Parameter(ParameterSetName = 'name', Mandatory, Position = 0)]
        [string]
        $name,
        [switch]
        [Parameter()]
        $EnableException
    )
    $invokeCucmAxlSplat = @{
        entity          = 'getLineGroup'
        parameters      = @{
        }
        EnableException = $EnableException
    }
    if($PSCmdlet.ParameterSetName -eq 'name') {
        $invokeCucmAxlSplat.parameters.name = $name
    }
    if($PSCmdlet.ParameterSetName -eq 'uuid') {
        $invokeCucmAxlSplat.parameters.uuid = $uuid
    }
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | Select-Xml -XPath '//lineGroup' | Select-Object -ExpandProperty Node
}
