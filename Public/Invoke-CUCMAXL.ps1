function Invoke-CUCMAXL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $entity,
        [Parameter(Mandatory=$true)]
        [hashtable]
        $parameters,
        [string]
        $AXLVersion = '11.5',
        [Parameter(Mandatory=$true)]
        [string]
        $server,
        [Parameter(Mandatory=$true)]
        [pscredential]
        $Credential
    )
    $User = 'powershell'
    $Password = 'P0werThaShell'
    $CUCMURL = "https://$server/axl/"

    $headers = @{
        'Content-Type' = 'text/xml; charset=utf-8'
        SOAPAction     = '"CUCM:DB ver={0} {1}"' -f $AXLVersion, $entity
        Authorization  = 'Basic ' + [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($User):$Password"))
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
        'Headers' = $headers
        'Body'    = $body
        'Uri'     = $CUCMURL
        'Method'  = 'Post'
    }
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $IRMParams.SkipCertificateCheck = $true
    }
    else {
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    }
    Invoke-restmethod @IRMParams |
        Select-XML -XPath '//return' |
        Select-Object -ExpandProperty Node
}