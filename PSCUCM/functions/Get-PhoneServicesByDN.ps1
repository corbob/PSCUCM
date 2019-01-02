﻿function Get-PhoneServicesByDN {
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
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER OutputXml
    Enable the output of the XML instead of the processing of the entity.
    
    .EXAMPLE
    Get-PhoneServicesByDN -DN 123 -server 'Cucm-Pub.example.com' -Credential (Get-Credential)

    Get the Phone Services of phone with DN 123
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
    $PhoneByDNSplat = @{
        DN            = $DN
        server        = $server
        Credential    = $Credential
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
    Get-PhoneByDN @PhoneByDNSplat |
        Select-Xml -XPath '//service' |
        Select-Object -ExpandProperty node
}