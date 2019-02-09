Import-Module $PSScriptRoot\..\..\..\PSCUCM.psd1 -Force

Describe "Get-PSCUCMTranslationPattern" {
    BeforeAll {
        [xml]$AxlReturn = @'
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
        <soapenv:Header/>
        <soapenv:Body>
            <ns:getTransPattern>
                <pattern>lkj</pattern><routePartitionName></routePartitionName>
            </ns:getTransPattern>
        </soapenv:Body>
    </soapenv:Envelope>
'@
        [xml]$RoutePartitionNameAxlReturn = @'
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
        <soapenv:Header/>
        <soapenv:Body>
            <ns:getTransPattern>
                <pattern>lkj</pattern><routePartitionName>RoutePartition</routePartitionName>
            </ns:getTransPattern>
        </soapenv:Body>
    </soapenv:Envelope>
'@
        $getPSCUCMTranslationPatternSplat = @{
            TranslationPattern = 'lkj'
        }
    }
    It "Returns appropriate XML for Starting a sync" {
        [xml]$return = Get-PSCUCMTranslationPattern @getPSCUCMTranslationPatternSplat -OutputXML
        $return.OuterXml | Should -Be $AxlReturn.OuterXml
    }
    It "Returns appropriate XML for cancelling a sync" {
        [xml]$return = Get-PSCUCMTranslationPattern @getPSCUCMTranslationPatternSplat -OutputXML -RoutePartitionName "RoutePartition"
        $return.OuterXml | Should -Be $RoutePartitionNameAxlReturn.OuterXml
    }
    It "Calls Invoke-PSCUCMAxlQuery" {
        Mock -CommandName Invoke-PSCUCMAxlQuery -MockWith {} -ModuleName PSCUCM
        Get-PSCUCMTranslationPattern @getPSCUCMTranslationPatternSplat
        Assert-MockCalled -CommandName Invoke-PSCUCMAxlQuery -Times 1 -Exactly -ModuleName PSCUCM
    }
}