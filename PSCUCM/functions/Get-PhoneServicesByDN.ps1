function Get-PhoneServicesByDN {
    <#
    .SYNOPSIS
    Get the services assigned to the phone based on the DN.
    
    .DESCRIPTION
    Get the services assigned to the phone based on the DN.
    
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
    An example
    
    .NOTES
    General notes
    #>
    
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
    $PhoneByDNSplat = @{
        'DN' = $DN
        'server' = $server
        'Credential' = $Credential
    }
    Get-PhoneByDN @PhoneByDNSplat |
        Select-Xml -XPath '//service' |
        Select-Object -ExpandProperty node
}