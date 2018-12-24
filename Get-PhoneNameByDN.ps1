function Get-PhoneNameByDN {
    [CmdletBinding()]
    param (
        [string]
        $DN,
        [string]
        $server = '10.10.20.1'
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
    }
    Invoke-CUCMAXL @CUCMAXL
}