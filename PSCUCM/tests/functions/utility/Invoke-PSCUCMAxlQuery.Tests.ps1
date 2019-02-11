Import-Module $PSScriptRoot\..\..\..\PSCUCM.psd1 -Force

Describe "Invoke-PSCUCMAxlQuery" {
    BeforeAll {
        [xml]$AxlReturn = @'
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
    <soapenv:Header/>
    <soapenv:Body>
    <ns:getPhone>
        <name>MyName</name>
    </ns:getPhone>
    </soapenv:Body>
</soapenv:Envelope>
'@

        $invokePSCucmAxlQuerySplat = @{
            Parameters = @{
                Name = 'MyName'
            }
            Entity     = 'getPhone'
        }
        $ConnectPSCucmSplat = @{
            AXLVersion = '11.5'
            Server     = '127.0.0.1'
            Credential = [System.Management.Automation.PSCredential]::new('user',(ConvertTo-SecureString 'pass' -AsPlainText -Force))
        }
        Connect-PSCucm @ConnectPSCucmSplat
        Mock -CommandName Invoke-WebRequest -MockWith {
            if($server -eq 'invalid') {
                throw "That's invalid sir!"
            }
        } -ModuleName PSCUCM        
    }
    It "Calls Invoke-WebRequest" {
        
        Invoke-PSCUCMAxlQuery @invokePSCucmAxlQuerySplat
        Assert-MockCalled -CommandName Invoke-WebRequest -Times 1 -ModuleName PSCUCM
    }
    It "Returns appropriate XML" {
        [xml]$return = Invoke-PSCUCMAxlQuery @invokePSCucmAxlQuerySplat -OutputXml
        $return.OuterXml | Should -Be $AxlReturn.OuterXml
    }
    It "Writes a warning when EnableException is not set." {
        $ConnectPSCucmSplat.Server = 'invalid'
        Connect-PSCucm @ConnectPSCucmSplat
        $file = New-TemporaryFile
        Invoke-PSCUCMAxlQuery @invokePSCucmAxlQuerySplat 3> $file
        Get-Content $file | Should -BeLikeExactly "*Failed to execute AXL entity getPhone."
        Remove-Item $file
    }
    It "Throws an exception when EnableException is set." {
        $ConnectPSCucmSplat.Server = 'invalid'
        Connect-PSCucm @ConnectPSCucmSplat
        { Invoke-PSCUCMAxlQuery @invokePSCucmAxlQuerySplat -EnableException } | Should -Throw
    }
}