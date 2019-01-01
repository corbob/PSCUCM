function New-Phone {
    [CmdletBinding()]
    param (
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
    
    $name = 'MyName'
    $product = 'Cisco Dual Mode for Android'
    $class = 'Phone'
    $protocolSide = 'User'
    $devicePoolName = 'Default'
    $commonPhoneConfigName = 'Standard Common Phone Profile'
    $locationName = 'Hub_None'
    $useTrustedRelayPoint = 'Default'
    $phoneTemplateName = 'Standard Dual Mode for Android'
    $primaryPhoneName = ''
    $deviceMobilityMode = 'Default'
    $certificateOperation = 'No Pending Operation'
    $packetCaptureMode = 'None'
    $builtInBridgeStatus = 'Default'
    $protocol = 'SIP'
    
    $XML = @'
    <phone>
        <name>{0}</name>
        <product>{1}</product>
        <class>{2}</class>
        <protocol>{14}</protocol>
        <protocolSide>{3}</protocolSide>
        <devicePoolName>{4}</devicePoolName>
        <commonPhoneConfigName>{5}</commonPhoneConfigName>
        <locationName>{6}</locationName>
        <useTrustedRelayPoint>{7}</useTrustedRelayPoint>
        <phoneTemplateName>{8}</phoneTemplateName>
        <primaryPhoneName />
        <deviceMobilityMode>{10}</deviceMobilityMode>
        <certificateOperation>{11}</certificateOperation>
        <packetCaptureMode>{12}</packetCaptureMode>
        <builtInBridgeStatus>{13}</builtInBridgeStatus>
    </phone>
'@ -f $name,
    $product,
    $class,
    $protocolSide,
    $devicePoolName,
    $commonPhoneConfigName,
    $locationName,
    $useTrustedRelayPoint,
    $phoneTemplateName,
    $primaryPhoneName,
    $deviceMobilityMode,
    $certificateOperation,
    $packetCaptureMode,
    $builtInBridgeStatus,
    $protocol
    
    $XML
}
