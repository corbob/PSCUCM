function Invoke-PSCUCMAxlQuery {
    <#
    .SYNOPSIS
    Invoke an AXL Query
    
    .DESCRIPTION
    Invoke an AXL Query against the connected server.
    
    .PARAMETER Entity
    AXL Entity to invoke.
    
    .PARAMETER Parameters
    Parameters for the AXL Entity.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.
    
    .PARAMETER OutputXml
    Output XML for the query instead of invoking it.

    .PARAMETER WhatIf
    What If?
    
    .PARAMETER Confirm
    Confirm...
    
    .EXAMPLE
    Invoke-PSCUCMAxlQuery -Entity getUser -Parameters @{ name = 'administrator' } -OutputXML

    Outputs the XML that would be sent to CUCM server.
    
    .NOTES
    OutputXML does *not* need a connected CUCM server to run.
    #>
    
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Entity,
        [Parameter(Mandatory = $true)]
        [hashtable]
        $Parameters,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    $AXLVersion = Get-PSFConfigValue -FullName pscucm.axlversion
    Write-PSFMessage -Level Debug -Message "AXL Version: $AXLVersion"
    if (-not $OutputXml) {
        Write-PSFMessage -Level Verbose -Message "Attempting to query $Entity" -Target $Parameters
        $EnableException = $EnableException -or $(Get-PSFConfigValue -FullName pscucm.enableexception)
        if (-not (Get-PSFConfigValue -FullName pscucm.connected)) {
            Stop-PSFFunction -Message "Unable to process AXL request. Not connected." -EnableException $EnableException
            return
        }
        $Server = Get-PSFConfigValue -FullName pscucm.server
        Write-PSFMessage -Level Debug -Message "Querying $Server"
        $Credential = Get-PSFConfigValue -FullName pscucm.credential
        Write-PSFMessage -Level Debug -Message "Using username: $($Credential.Username)"
    }
    $object = @{
        'soapenv:Header' = ''
        'soapenv:Body' = @{
            "ns:$entity" = $Parameters
        }
    }
    $body = ConvertTo-XMLString -InputObject $object -ObjectName "soapenv:Envelope" -RootAttributes @{"xmlns:soapenv"="http://schemas.xmlsoap.org/soap/envelope/"; "xmlns:ns"="http://www.cisco.com/AXL/API/$AXLVersion"}
    Write-PSFMessage -Level Debug -Message "Generated XML for Entity: $Entity" -Target $body
    if (-not $OutputXml) {
        if ($PSCmdlet.ShouldProcess($Server, "Execute AXL query $Entity")) {
            $CUCMURL = "https://$Server/axl/"
            $headers = @{
                'Content-Type' = 'text/xml; charset=utf-8'
            }
            $IRMParams = @{
                Headers    = $headers
                Body       = $body
                Uri        = $CUCMURL
                Method     = 'Post'
                Credential = $Credential
            }
            if (Get-PSFConfigValue -FullName pscucm.skipcertificatecheck) {
                if ($PSVersionTable.PSVersion.Major -ge 6) {
                    $IRMParams.SkipCertificateCheck = $true
                }
                else {
                    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
                }
            }
            try {
                Invoke-WebRequest @IRMParams |
                    Select-XML -XPath '//return' |
                    Select-Object -ExpandProperty Node
            }
            catch {
                $ErrorMessage = $_.ErrorDetails.message
                $PSFMessage = "Failed to execute AXL entity $Entity."
                if (($null -ne $ErrorMessage) -and ($_.Exception.Response.StatusCode -eq 'InternalServerError')) {
                    if ($PSVersionTable.PSVersion.Major -ge 6) {
                        $null = $ErrorMessage -match "(\d+)(.*)$Entity"
                        $axlcode = $Matches[1]
                        $axlMessage = $Matches[2]
                    }
                    else {
                        $axlcode = ($ErrorMessage | select-xml -XPath '//axlcode' | Select-Object -ExpandProperty Node).'#text'
                        $axlMessage = ($ErrorMessage | select-xml -XPath '//axlmessage' | Select-Object -ExpandProperty Node).'#text'
                    }
                    $PSFMessage += " AXL Error: $axlMessage ($axlcode)"
                }
                Stop-PSFFunction -Message $PSFMessage -ErrorRecord $_ -EnableException $EnableException -Target $body
                return
            }
        }
    }
    else {
        $body
    }
}
