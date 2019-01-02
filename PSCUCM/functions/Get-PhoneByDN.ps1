function Get-PhoneByDN {
    <#
    .SYNOPSIS
    Get the phone(s) based upon the DN
    
    .DESCRIPTION
    Get the phone(s) based upon the DN
    
    .PARAMETER DN
    Directory Number to lookup
    
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
    Get-PhoneByDN -DN 123 -server 'Cucm-Pub.example.com' -Credential (Get-Credential)

    Get Phone with DN 123
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $DN,
        [Parameter(Mandatory = $true)]
        [string]
        $server,
        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $phoneNameByDNSplat = @{
        DN              = $DN
        server          = $server
        Credential      = $Credential
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    $phoneName = Get-PhoneNameFromDN @phoneNameByDNSplat |
        Select-Xml -XPath '//name' |
        Select-Object -ExpandProperty node |
        Select-Object -ExpandProperty '#text'
    $CucmAxlSplat = @{
        'server'     = $server
        'entity'     = 'getPhone'
        'parameters' = @{
            'name' = $phoneName
        }
        'Credential' = $Credential
    }
    Invoke-CucmAxl @CucmAxlSplat | Select-Xml -XPath '//phone' | Select-Object -ExpandProperty node
}