function Remove-PSCUCMPhone {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $DN,
        [switch]
        $EnableException
    )
    Invoke-PSCUCMAxlQuery @CucmAxlSplat | Select-Xml -XPath '//phone' | Select-Object -ExpandProperty node
}