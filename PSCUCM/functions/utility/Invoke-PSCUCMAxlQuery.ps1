function Invoke-PSCUCMAxlQuery {
    
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
    if (-not $OutputXml) {
        $EnableException = $EnableException -or $(Get-PSFConfigValue -FullName pscucm.enableexception)
        if (-not (Get-PSFConfigValue -FullName pscucm.connected)) {
            Stop-PSFFunction -Message "Unable to process AXL request. Not connected." -EnableException $EnableException
        }
        $Server = Get-PSFConfigValue -FullName pscucm.server
        $Credential = Get-PSFConfigValue -FullName pscucm.credential
    }
    $object = @{
        'soapenv:Header' = ''
        'soapenv:Body' = @{
            "ns:$entity" = $Parameters
        }
    }
    $body = ConvertTo-XMLString -InputObject $object -ObjectName "soapenv:Envelope" -RootAttributes @{"xmlns:soapenv"="http://schemas.xmlsoap.org/soap/envelope/"; "xmlns:ns"="http://www.cisco.com/AXL/API/$AXLVersion"}
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
                Stop-PSFFunction -Message $PSFMessage -ErrorRecord $_ -EnableException $EnableException
                return
            }
        }
    }
    else {
        $body
    }
}
