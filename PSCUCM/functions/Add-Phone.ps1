function Add-Phone {
    <#
    .SYNOPSIS
    Add a Phone to CUCM Environment
    
    .DESCRIPTION
    Add a Phone to CUCM Environment
    
    .PARAMETER MacAddress
    MacAddress for the phone
    
    .PARAMETER Product
    Product
    
    .PARAMETER protocolSide
    Protocol Side (User?)
    
    .PARAMETER devicePoolName
    Name of DevicePool to put phone in.
    
    .PARAMETER commonPhoneConfigName
    Parameter description
    
    .PARAMETER phoneTemplateName
    Parameter description
    
    .PARAMETER Protocol
    Parameter description
    
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
    
    .PARAMETER WhatIf
    What If?
    
    .PARAMETER Confirm
    Confirm...
    
    .EXAMPLE
    An example
    
    with more here...
    
    .NOTES
    General notes
    #>
    
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
        server          = $server
        AXLVersion      = $AXLVersion
        Credential      = $Credential
        EnableException = $EnableException
        OutputXml       = $OutputXml
    }
        
    Invoke-CucmAxl @CucmAxlSplat
    
}
