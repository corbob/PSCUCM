function Disconnect-PSCucm {
    <#
    .SYNOPSIS
    "Disconnect" from CUCM Server
    
    .DESCRIPTION
    "Disconnect" from CUCM Server
    
    .EXAMPLE
    Disconnect-PSCucm

    Disconnects from CUCM Server.
    
    .NOTES
    General notes
    #>
    
    [CmdletBinding()]
    param (
    )
    Reset-PSFConfig -Module pscucm
    $Global:PSDefaultParameterValues.remove('*-PSCucm*:EnableException')
}