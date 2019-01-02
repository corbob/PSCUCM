function Invoke-CucmAxl {
    <#
    .SYNOPSIS
    Invoke AXL request against a CUCM server
    
    .DESCRIPTION
    Invoke AXL request against a CUCM server.
    
    .PARAMETER entity
    AXL entity to request
    
    .PARAMETER parameters
    Parameters for the AXL request
    
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
    Invoke-CucmAxl -entity 'getPhone' -parameters @{ name = 'SEP000000000000' } -server 'Cucm-Pub.example.com' -Credential (Get-Credential)
    
    Invoke getPhone Entity with parameters...
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $entity,
        [Parameter(Mandatory = $true)]
        [hashtable]
        $parameters,
        [string]
        $AXLVersion = '11.5',
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
    $params = ''
    foreach ($paramKey in $parameters.Keys) {
        $inner = ''
        if ($parameters[$paramKey].GetType() -eq [System.Collections.Hashtable]) {
            $innerHash = $parameters[$paramKey]
            foreach ($innerKey in $innerHash.Keys) {
                $inner += '<{0}>{1}</{0}>' -f $innerKey, $innerHash[$innerKey]
            }
        }
        else {
            $inner = $parameters[$paramKey]
        }
        $params += '<{0}>{1}</{0}>' -f $paramKey, $inner
    }
    $body = @'
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/{0}">
        <soapenv:Header/>
        <soapenv:Body>
            <ns:{1}>
                {2}
            </ns:{1}>
        </soapenv:Body>
    </soapenv:Envelope>
'@ -f $AXLVersion, $entity, $params
    
    if (-not $OutputXml) {
        if($PSCmdlet.ShouldProcess($server, "Execute AXL query $entity")) {
        
        $CUCMURL = "https://$server/axl/"
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
        if ($PSVersionTable.PSVersion.Major -ge 6) {
            $IRMParams.SkipCertificateCheck = $true
        }
        else {
            [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
        }
        try {
            Invoke-WebRequest @IRMParams |
                Select-XML -XPath '//return' |
                Select-Object -ExpandProperty Node
        }
        catch {
            $ErrorMessage = $_.ErrorDetails.message
            $PSFMessage = "Failed to execute AXL entity $entity."
            if (($null -ne $ErrorMessage) -and ($_.Exception.Response.StatusCode -eq 'InternalServerError')) {
                $axlcode = ($ErrorMessage | select-xml -XPath '//axlcode' | Select-Object -ExpandProperty Node).'#text'
                $axlMessage = ($ErrorMessage | select-xml -XPath '//axlmessage' | Select-Object -ExpandProperty Node).'#text'
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
