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
    Enable throwing of exception when API throws error.
    
    .EXAMPLE
    Get-PhoneByDN -DN 123 -server 'Cucm-Pub.example.com' -Credential (Get-Credential)

    .EXAMPLE
    Get-PhoneByDN -DN 123 -server 'Cucm-Pub.example.com' -Credential (Get-Credential) -EnableException

    .NOTES
    These are the notes...
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
        $Credential
    )
    $phoneNameByDNSplat = @{
        'DN'         = $DN
        'server'     = $server
        'Credential' = $Credential
    }
    $phoneName = Obtain-PhoneNameFromDN @phoneNameByDNSplat |
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