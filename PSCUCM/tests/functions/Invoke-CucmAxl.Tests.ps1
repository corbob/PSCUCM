Import-Module $PSScriptRoot\..\..\PSCUCM.psd1 -Force

Describe "Invoke-CucmAxl" {
    BeforeAll {
        $AxlReturn = @'
<return><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
    <soapenv:Header/>
    <soapenv:Body>
    <ns:getPhone>
        <name>MyName</name>
    </ns:getPhone>
    </soapenv:Body>
</soapenv:Envelope></return>
'@ | Select-Xml -XPath '//return' | Select-Object -ExpandProperty Node
        $CucmAxlSplat = @{
            server     = '127.0.0.1'
            entity     = 'getPhone'
            parameters = @{
                name = 'MyName'
            }
            credential = [System.Management.Automation.PSCredential]::new('user',(ConvertTo-SecureString 'pass' -AsPlainText -Force))
        }
        Mock -CommandName Invoke-WebRequest -MockWith {
            if($server -eq 'invalid') {
                throw "That's invalid sir!"
            }
            Write-Output "<return>$body</return>"
        } -ModuleName PSCUCM        
    }
    It "Calls Invoke-WebRequest" {
        Invoke-CucmAxl @CucmAxlSplat
        Assert-MockCalled -CommandName Invoke-WebRequest -Times 1 -Exactly -ModuleName PSCUCM
    }
    It "Returns appropriate XML" {
        $return = Invoke-CucmAxl @CucmAxlSplat
        $return.outerXml | Should -Be $AxlReturn.outerXml
    }
    It "Writes a warning when an exception is raised" {
        $splat = $($CucmAxlSplat)
        $splat['server'] = 'invalid'
        Invoke-CucmAxl @CucmAxlSplat 3> TestDrive:\Output.txt
        Get-Content TestDrive:\Output.txt | Should -BeLike "*That's invalid sir!"
    }
    It "Throws an exception when EnableException is set." {
        $splat = $($CucmAxlSplat)
        $splat['server'] = 'invalid'
        Invoke-CucmAxl @CucmAxlSplat -EnableException | Should -Throw
    } -Skip
}