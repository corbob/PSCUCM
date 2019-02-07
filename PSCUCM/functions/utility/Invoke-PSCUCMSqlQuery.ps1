function Invoke-PSCUCMSqlQuery {
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
        [Parameter(ParameterSetName = 'NotOutputXml')]
        [switch]
        $EnableException,
        [Parameter(ParameterSetName = 'OutputXml')]
        [switch]
        $OutputXml
    )
    $AXLVersion = Get-PSFConfigValue -FullName pscucm.axlversion
    $Server = Get-PSFConfigValue -FullName pscucm.server
    $Credential = Get-PSFConfigValue -FullName pscucm.credential
    $CucmAxlSplat = @{
        entity     = 'executeSQLQuery'
        parameters = @{
            sql = $SqlQuery
        }
        AXLVersion = $AXLVersion
    }
    if (-not $OutputXml) {
        $CucmAxlSplat.server = $server
        $CucmAxlSplat.Credential = $Credential
        $CucmAxlSplat.EnableException = $EnableException
    }
    else {
        $CucmAxlSplat.OutputXml = $OutputXml
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat
}