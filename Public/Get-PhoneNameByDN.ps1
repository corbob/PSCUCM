function Get-PhoneNameByDN {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $DN,
        [Parameter(Mandatory=$true)]
        [string]
        $server,
        [Parameter(Mandatory=$true)]
        [pscredential]
        $Credential
    )
    $CUCMAXL = @{
        'entity'     = 'executeSQLQuery'
        'parameters' = @{
            'sql' = @'
            SELECT device.name 
            FROM 
            device, numplan, devicenumplanmap
            WHERE
            devicenumplanmap.fkdevice = device.pkid 
            AND 
            devicenumplanmap.fknumplan = numplan.pkid 
            AND
            numplan.dnorpattern = "{0}"
'@ -f $DN
        }
        'server' = $server
        'Credential' = $Credential
    }
    Invoke-CUCMAXL @CUCMAXL
}