﻿Import-Module $PSScriptRoot\..\..\..\PSCUCM.psd1 -Force

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
        $invokePSCucmSqlQuerySplat = @{
            server     = '127.0.0.1'
            credential = [System.Management.Automation.PSCredential]::new('user', (ConvertTo-SecureString 'pass' -AsPlainText -Force))
        }
        $CucmSqlSplat = @{
            AXLVersion = 11.5
            SqlQuery   = 'MyName'
        }
        Mock -CommandName Invoke-WebRequest -MockWith {
            if ($server -eq 'invalid') {
                throw "That's invalid sir!"
            }
        } -ModuleName PSCUCM        
    }
    It "Calls Invoke-WebRequest" {
        Invoke-PSCUCMSqlQuery @invokePSCucmSqlQuerySplat @CucmSqlSplat
        Assert-MockCalled -CommandName Invoke-WebRequest -Times 1 -Exactly -ModuleName PSCUCM
    }
    It "Returns appropriate XML" {
        [xml]$return = Invoke-PSCUCMSqlQuery @CucmSqlSplat -OutputXml
        $return.OuterXml | Should -Be $AxlReturn.OuterXml
    }
    It "Throws an exception when EnableException is set." {
        $invokePSCucmSqlQuerySplat['server'] = 'invalid'
        { Invoke-PSCUCMSqlQuery @invokePSCucmSqlQuerySplat @CucmSqlSplat -EnableException } | Should -Throw
    }
}