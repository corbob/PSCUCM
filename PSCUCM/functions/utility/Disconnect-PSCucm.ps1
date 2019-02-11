function Disconnect-PSCucm {
    [CmdletBinding()]
    param (
    )
    Reset-PSFConfig -Module pscucm
    $Global:PSDefaultParameterValues.remove('*-PSCucm*:EnableException')
}