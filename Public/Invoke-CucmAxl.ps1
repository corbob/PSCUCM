function Invoke-CucmAxl {
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
        $Credential
    )
    $CUCMURL = "https://$server/axl/"

    $headers = @{
        'Content-Type' = 'text/xml; charset=utf-8'
        SOAPAction     = '"CUCM:DB ver={0} {1}"' -f $AXLVersion, $entity
    }
    $params = foreach ($paramKey in $parameters.Keys) {
        '<{0}>{1}</{0}>' -f $paramKey, $parameters[$paramKey]
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

    $IRMParams = @{
        'Headers'    = $headers
        'Body'       = $body
        'Uri'        = $CUCMURL
        'Method'     = 'Post'
        'Credential' = $Credential
    }
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $IRMParams.SkipCertificateCheck = $true
    }
    else {
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    }
    try {
        Invoke-RestMethod @IRMParams |
            Select-XML -XPath '//return' |
            Select-Object -ExpandProperty Node
    }
    catch {
        Write-warning "Failed to execute AXL entity $entity. Error: $($_.exception)"
    }
}
