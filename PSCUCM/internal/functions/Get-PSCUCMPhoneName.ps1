function Get-PSCUCMPhoneName {
    <#
    .SYNOPSIS
    Get Phone Name based off of DN
    
    .DESCRIPTION
    Get Phone Name based off of DN
    
    .PARAMETER DN
    Directory Number to get phone for
    
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
    Get-PhoneNameFromDN -DN 123 -Server 'CUCM-PUB.example.com' -Credential (Get-Credential)

    Get the Phone Name for Directory Number 123
    #>
    
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
        $Credential,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
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
        server          = $server
        Credential      = $Credential
        AXLVersion      = $AXLVersion
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    Invoke-PSCUCMSqlQuery @CucmAxlSplat
}