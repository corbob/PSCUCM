function Add-PSCUCMPhone {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $true)]
        [Alias('Model')]
        [string]
        $Product,
        [Parameter(Mandatory=$true)]
        [string]
        $DevicePoolName,
        [Parameter(Mandatory = $true)]
        [string]
        $Protocol,
        [Parameter()]
        [string]
        $Description,
        [Parameter()]
        [switch]
        $EnableException,
        [Parameter()]
        [switch]
        $OutputXml
    )

    <#
         <phone>
            <name>SEP000000000000</name>
            <description>Optional</description>
            <product>?</product>
            <class>?</class>
            <protocol>?</protocol>
            <protocolSide>User</protocolSide>
            <devicePoolName uuid="?">?</devicePoolName>
         </phone>
    #>
        
    $class = 'Phone'
    
    $CucmAxlSplat = @{
        entity          = 'addPhone'
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
                phoneTemplateName     = $Template
                primaryPhoneName      = $primaryPhoneName
                deviceMobilityMode    = $deviceMobilityMode
                certificateOperation  = $certificateOperation
                packetCaptureMode     = $packetCaptureMode
                builtInBridgeStatus   = $builtInBridgeStatus
                description           = $Description
            }
        }
        OutputXml       = $OutputXml
        EnableException = $EnableException
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat
    
}
