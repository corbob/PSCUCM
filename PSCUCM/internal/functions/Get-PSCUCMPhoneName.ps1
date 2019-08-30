function Get-PSCUCMPhoneName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $DN,
        [switch]
        $EnableException
    )
    $CucmAxlSplat = @{
        SqlQuery        = @'
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
        EnableException = $EnableException
    }
    Invoke-PSCUCMSqlQuery @CucmAxlSplat
}