function Invoke-CucmSql {
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
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER OutputXml
    Enable the output of the XML instead of the processing of the entity.
    
    .EXAMPLE
    Invoke-CucmSql -SqlQuery 'select name from devices where name = "SEP000000000000"'  -server 'Cucm-Pub.example.com' -Credential (Get-Credential)

    Invoke SQL Query against server...
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
        $Credential,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $CucmAxlSplat = @{
        server     = $server
        entity     = 'executeSQLQuery'
        parameters = @{
            sql = $SqlQuery
        }
        AXLVersion = $AXLVersion
        Credential = $Credential
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    Invoke-CucmAxl @CucmAxlSplat
}