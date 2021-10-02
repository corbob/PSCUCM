function Get-PSCUCMHuntList {
    <#
    .SYNOPSIS
    Get Hunt List
    
    .DESCRIPTION
    Get Hunt List
    
    .PARAMETER uuid
    UUID of hunt list
    
    .PARAMETER name
    Name of the hunt list
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Get-PSCUCMHuntList 'My Hunt List'

    Get Hunt List named 'My Hunt List'
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
        entity          = 'getHuntList'
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
    Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat | Select-Xml -XPath '//huntList' | Select-Object -ExpandProperty Node
}
