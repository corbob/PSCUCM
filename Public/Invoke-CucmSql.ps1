function Invoke-CucmSql {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $SqlQuery,
        [string]
        $AXLVersion = '11.5',
        [Parameter(Mandatory=$true)]
        [string]
        $server,
        [Parameter(Mandatory=$true)]
        [pscredential]
        $Credential
    )
    $CucmAxlSplat = @{
        'server' = $server
        'entity' = 'executeSQLQuery'
        'parameters' = @{
            'sql' = $SqlQuery
        }
        'AXLVersion' = $AXLVersion
        'Credential' = $Credential
    }
    Invoke-CucmAxl @CucmAxlSplat
}