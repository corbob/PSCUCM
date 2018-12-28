function Obtain-PhoneNameFromDN {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $DN,
        [Parameter(Mandatory = $true)]
        [string]
        $server,
        [string]
        $AXLVersion = '11.5',
        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential
    )
    $CucmAxlSplat = @{
        'SqlQuery'   = @'
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
        'server'     = $server
        'Credential' = $Credential
        'AXLVersion' = $AXLVersion
    }
    Invoke-CucmAxl @CucmAxlSplat
}