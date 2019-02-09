Import-Module $PSScriptRoot\..\..\..\PSCUCM.psd1 -Force

Describe "Set-PSCUCMTranslationPattern" {
    BeforeAll {
        [xml]$AxlReturn = @'
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
    <soapenv:Header/>
    <soapenv:Body>
        <ns:updateTransPattern>
            <pattern>TranslationPattern</pattern><calledPartyTransformationMask>CalledPartyTransformationMask</calledPartyTransformationMask><routePartitionName>RoutePartition</routePartitionName>
        </ns:updateTransPattern>
    </soapenv:Body>
</soapenv:Envelope>
'@
        $setPSCUCMTranslationPatternSplat = @{
            TranslationPattern            = 'TranslationPattern'
            RoutePartition                = 'RoutePartition'
            CalledPartyTransformationMask = 'CalledPartyTransformationMask'
        }
    }
    It "Returns appropriate XML for setting a TranslationPattern" {
        [xml]$return = Set-PSCUCMTranslationPattern @setPSCUCMTranslationPatternSplat -OutputXML
        $return.SelectNodes('//pattern').OuterXml | Should -Be $AxlReturn.SelectNodes('//pattern').OuterXml
        $return.SelectNodes('//calledPartyTransformationMask').OuterXml | Should -Be $AxlReturn.SelectNodes('//calledPartyTransformationMask').OuterXml
        $return.SelectNodes('//routePartitionName').OuterXml | Should -Be $AxlReturn.SelectNodes('//routePartitionName').OuterXml
    }
    It "Returns appropriate XML for setting just the Called Party Transformation Mask" {
        [xml]$return = Set-PSCUCMTranslationPattern -TranslationPattern 'TranslationPattern' -CalledPartyTransformationMask 'CalledPartyTransformationMask'  -OutputXML
        $return.SelectNodes('//pattern').OuterXml | Should -Be $AxlReturn.SelectNodes('//pattern').OuterXml
        $return.SelectNodes('//calledPartyTransformationMask').OuterXml | Should -Be $AxlReturn.SelectNodes('//calledPartyTransformationMask').OuterXml
    }
    It "Returns appropriate XML for setting just the Route Partition" {
        [xml]$return = Set-PSCUCMTranslationPattern -TranslationPattern 'TranslationPattern' -RoutePartitionName 'RoutePartition' -OutputXML
        $return.SelectNodes('//pattern').OuterXml | Should -Be $AxlReturn.SelectNodes('//pattern').OuterXml
        $return.SelectNodes('//routePartitionName').OuterXml | Should -Be $AxlReturn.SelectNodes('//routePartitionName').OuterXml
    }
    It "Calls Invoke-PSCUCMAxlQuery" {
        Mock -CommandName Invoke-PSCUCMAxlQuery -MockWith {} -ModuleName PSCUCM
        Set-PSCUCMTranslationPattern @setPSCUCMTranslationPatternSplat
        Assert-MockCalled -CommandName Invoke-PSCUCMAxlQuery -Times 1 -Exactly -ModuleName PSCUCM
    }
}