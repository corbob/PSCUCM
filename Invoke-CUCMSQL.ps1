function Invoke-CUCMSQL {
    [CmdletBinding()]
    param (
        [string]
        $SQL,
        [string]
        $AXLVersion = '11.5',
        [string]
        $server = '10.10.20.1'
    )
    $User = 'powershell'
    $Password = 'P0werThaShell'
    $CUCMURL = "https://$server/axl/"

    $headers = @{
        'Content-Type' = 'text/xml; charset=utf-8'
        SOAPAction     = '"CUCM:DB ver={0} executeSQLQuery"' -f $AXLVersion
        Authorization  = 'Basic ' + [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($User):$Password"))
    }
    $body = @'
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/{0}">
          <soapenv:Header/>
          <soapenv:Body>
            <ns:executeSQLQuery>
              <sql>{1}</sql>
            </ns:executeSQLQuery>
          </soapenv:Body>
        </soapenv:Envelope>
'@ -f $AXLVersion, $SQL
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    Invoke-restmethod -Uri  $CUCMURL -Method Post -Body $body -Headers $headers
}