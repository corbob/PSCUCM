function Invoke-PSCUCMSqlQuery {
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