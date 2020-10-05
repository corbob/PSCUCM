function Remove-PSCUCMPhone {
    <#
    .SYNOPSIS
    Remove a phone from CUCM
    
    .DESCRIPTION
    Remove a phoen from CUCM
    
    .PARAMETER Name
    Name of phone to remove
    
    .PARAMETER UUID
    UUID of phone to remove
    
    .PARAMETER EnableException
    Parameter description

    .PARAMETER WhatIf
    What If?
    
    .PARAMETER Confirm
    Confirm...
    
    .EXAMPLE
    Remove-PSCUCMPhone -UUID {3C33ADA6-70DF-F16C-C5B9-16CE14AE58B3}

    Removes phone with UUID {3C33ADA6-70DF-F16C-C5B9-16CE14AE58B3}

    #>
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