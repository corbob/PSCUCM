function Add-PSCUCMPhone {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $MacAddress,
        [Parameter(Mandatory = $true)]
        [string]
        $Product,
        [Parameter(Mandatory = $true)]
        [string]
        $protocolSide,
        [Parameter(Mandatory = $true)]
        [string]
        $devicePoolName,
        [Parameter(Mandatory = $true)]
        [string]
        $commonPhoneConfigName,
        [Parameter(Mandatory = $true)]
        [string]
        $phoneTemplateName,
        [Parameter(Mandatory = $true)]
        [string]
        $Protocol,
        [switch]
        $EnableException,
        [switch]
        $OutputXml
    )
    
    $class = 'Phone'
    $locationName = 'Hub_None'
    $useTrustedRelayPoint = 'Default'
    $primaryPhoneName = ''
    $deviceMobilityMode = 'Default'
    $certificateOperation = 'No Pending Operation'
    $packetCaptureMode = 'None'
    $builtInBridgeStatus = 'Default'
    
    $CucmAxlSplat = @{
        entity          = 'addPhone'
        # parameters      = @{
        #     phone = $phonexml
        # }
        parameters      = @{
            phone = @{
                name                  = $MacAddress
                product               = $Product
                class                 = $class
                protocol              = $Protocol
                protocolSide          = $protocolSide
                devicePoolName        = $devicePoolName
                commonPhoneConfigName = $commonPhoneConfigName
                locationName          = $locationName
                useTrustedRelayPoint  = $useTrustedRelayPoint
                phoneTemplateName     = $phoneTemplateName
                primaryPhoneName      = $primaryPhoneName
                deviceMobilityMode    = $deviceMobilityMode
                certificateOperation  = $certificateOperation
                packetCaptureMode     = $packetCaptureMode
                builtInBridgeStatus   = $builtInBridgeStatus
            }
        }
        OutputXml       = $OutputXml
        EnableException = $EnableException
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat
    
}
