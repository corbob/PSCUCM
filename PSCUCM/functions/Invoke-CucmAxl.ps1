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
    Enable throwing of exception when API throws error.
    
    .EXAMPLE
    Invoke-CucmAxl -entity 'getPhone' -parameters @{ name = 'SEP000000000000' } -server 'Cucm-Pub.example.com' -Credential (Get-Credential)
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
        $EnableException
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
        Invoke-RestMethod @IRMParams |
            Select-XML -XPath '//return' |
            Select-Object -ExpandProperty Node
    }
    catch {
        Stop-PSFFunction -Message "Failed to execute AXL entity $entity." -ErrorRecord $_ -EnableException $EnableException
        return
    }
}
