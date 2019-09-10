function Invoke-PSCUCMSqlQuery {
    <#
    .SYNOPSIS
    Invoke a SQL Query against CUCM Server.
    
    .DESCRIPTION
    Invoke a SQL Query against CUCM Server.
    
    .PARAMETER SqlQuery
    SQL Query to invoke.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER OutputXml
    Output just XML
    
    .EXAMPLE
    Invoke-PSCUCMSqlQuery -SqlQuery "Select * from phones"

    Will execute the query against the CUCM server. This is probably a bad query... Do *not* try this at home.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $SqlQuery,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $CucmAxlSplat = @{
        entity          = 'executeSQLQuery'
        parameters      = @{
            sql = $SqlQuery
        }
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat
}