function Invoke-PSCUCMLdapSync {
    <#
    .SYNOPSIS
    Invoke sync of LDAP Directory
    
    .DESCRIPTION
    Invoke sync of LDAP Directory
    
    .PARAMETER LdapDirectory
    LDAP Directory to sync
    
    .PARAMETER cancelActive
    Cancel active sync
    
    .PARAMETER AXLVersion
    AXL Version for Server.
    
    .PARAMETER server
    Server to query
    
    .PARAMETER Credential
    Credential to use for API access
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER OutputXml
    Enable the output of the XML instead of the processing of the entity.
        
    .PARAMETER WhatIf
    What If?
    
    .PARAMETER Confirm
    Confirm...
    
    .EXAMPLE
    An example

    System Up Time: 	0d, 0h, 13m
    #>
    
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $LdapDirectory,
        [switch]
        $cancelActive,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $invokeCucmAxlSplat = @{
        entity     = 'doLdapSync'
        parameters = @{
            name = $LdapDirectory
            sync = $true
        }
        AXLVersion = Get-PSFConfigValue -FullName pscucm.axlversion
        OutputXml  = $OutputXml
        EnableException = $EnableException
    }
    if ($cancelActive.IsPresent) {
        $invokeCucmAxlSplat.parameters.sync = $false
    }
    if ($PSCmdlet.ShouldProcess($server, "Set Translation Pattern $TranslationPattern")) {
        Invoke-PSCUCMAxlQuery @invokeCucmAxlSplat
    }
}
