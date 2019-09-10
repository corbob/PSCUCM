function Get-PSCUCMPhoneName {
    <#
    .SYNOPSIS
    Get the Phone Name based on Directory Number
    
    .DESCRIPTION
    Get the Phone Name based solely upon the Directory Number
    
    .PARAMETER DN
    Directory Number to get a phone name of...
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .EXAMPLE
    Get-PSCUCMPhoneName -DN 1001

    Gets the phone name for Directory Number 1001
    #>
    
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