Import-Module $PSScriptRoot\..\..\..\PSCUCM.psd1 -Force

Describe "Invoke-PSCUCMSqlQuery" {
    BeforeAll {
        [xml]$AxlReturn = @'
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
    <soapenv:Header/>
    <soapenv:Body>
    <ns:executeSqlQuery>
        <sql>MyName</sql>
    </ns:executeSqlQuery>
    </soapenv:Body>
</soapenv:Envelope>
'@
        $CucmSqlSplat = @{
            SqlQuery   = 'MyName'
        }
        $ConnectPSCucmSplat = @{
            AXLVersion = '11.5'
            Server     = '127.0.0.1'
            Credential = [System.Management.Automation.PSCredential]::new('user',(ConvertTo-SecureString 'pass' -AsPlainText -Force))
        }
        Connect-PSCucm @ConnectPSCucmSplat
    }
    It "Returns appropriate XML" {
        [xml]$return = Invoke-PSCUCMSqlQuery @CucmSqlSplat -OutputXml
        $return.OuterXml | Should -Be $AxlReturn.OuterXml
    }
    It "Calls Invoke-PSCUCMAxlQuery" {
        Mock -CommandName Invoke-PSCUCMAxlQuery -MockWith {} -ModuleName PSCUCM
        Invoke-PSCUCMSqlQuery @CucmSqlSplat
        Assert-MockCalled -CommandName Invoke-PSCUCMAxlQuery -Times 1 -Exactly -ModuleName PSCUCM
    }
}