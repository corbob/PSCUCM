function Add-PSCUCMPhone {
    <#
    .SYNOPSIS
    Adds a phone to CUCM.
    
    .DESCRIPTION
    Adds a phone of the appropriate parameters to CUCM.
    
    .PARAMETER Name
    Name of the phone.
    
    .PARAMETER Product
    Phone Model.
    
    .PARAMETER DevicePoolName
    Device Pool to place phone in.
    
    .PARAMETER Protocol
    Protocol for the phone. Typically SCCP or SIP.
    
    .PARAMETER Description
    Description for the phone.
    
    .PARAMETER EnableException
    Replaces user friendly yellow warnings with bloody red exceptions of doom!
    Use this if you want the function to throw terminating errors you want to catch.

    .PARAMETER WhatIf
    What If?
    
    .PARAMETER Confirm
    Confirm...
    
    .EXAMPLE
    Add-Phone -Name SEP00000000000 -Product 'Cisco 6941' -DevicePoolName 'DEFAULT-DP' -Protocol SCCP

    Adds a phone to CUCM.

    #>
    
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
        $EnableException
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
                name                  = $Name
                product               = $Product
                class                 = $class
                protocol              = $Protocol
                protocolSide          = $protocolSide
                devicePoolName        = $devicePoolName
                commonPhoneConfigName = $commonPhoneConfigName
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
        EnableException = $EnableException
    }
    Invoke-PSCUCMAxlQuery @CucmAxlSplat
    
}
