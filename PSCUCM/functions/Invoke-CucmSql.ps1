﻿function Invoke-CucmSql {
    <#
    .SYNOPSIS
    Invoke a SQL Query against CUCM server using the AXL API
    
    .DESCRIPTION
    Invoke a SQL Query against CUCM server using the AXL API
    
    .PARAMETER SqlQuery
    SQL Query to be run
    
    .PARAMETER AXLVersion
    Version of AXL
    
    .PARAMETER server
    Server to query
    
    .PARAMETER Credential
    Credential to use for API access
    
    .PARAMETER EnableException
    Enable throwing of exception when API throws error.
    
    .EXAMPLE
    An example
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $SqlQuery,
        [string]
        $AXLVersion = '11.5',
        [Parameter(Mandatory = $true)]
        [string]
        $server,
        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential
    )
    $CucmAxlSplat = @{
        'server'     = $server
        'entity'     = 'executeSQLQuery'
        'parameters' = @{
            'sql' = $SqlQuery
        }
        'AXLVersion' = $AXLVersion
        'Credential' = $Credential
    }
    Invoke-CucmAxl @CucmAxlSplat
}