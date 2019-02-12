# Import-Module $PSScriptRoot\..\..\..\PSCUCM.psd1 -Force

# Describe "Add-PSCUCMPhone" {
#     BeforeAll {
#         [xml]$AxlReturn = @'
# <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
#     <soapenv:Header/>
#     <soapenv:Body>
#     <ns:doLdapSync>
#         <sync>True</sync><name>lkj</name>
#     </ns:doLdapSync>
#     </soapenv:Body>
# </soapenv:Envelope>
# '@
#         [xml]$CancelAxlReturn = @'
# <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.cisco.com/AXL/API/11.5">
#     <soapenv:Header/>
#     <soapenv:Body>
#         <ns:doLdapSync>
#             <sync>False</sync><name>lkj</name>
#         </ns:doLdapSync>
#     </soapenv:Body>
# </soapenv:Envelope>
# '@
#         $ConnectPSCucmSplat = @{
#             AXLVersion = '11.5'
#             Server     = '127.0.0.1'
#             Credential = [System.Management.Automation.PSCredential]::new('user',(ConvertTo-SecureString 'pass' -AsPlainText -Force))
#         }
#         Connect-PSCucm @ConnectPSCucmSplat
#     }
#     It "Calls Invoke-PSCUCMAxlQuery" {
#         Mock -CommandName Invoke-PSCUCMAxlQuery -MockWith {} -ModuleName PSCUCM
#         Invoke-PSCUCMLdapSync @invokePSCUCMLdapSyncSplat
#         Assert-MockCalled -CommandName Invoke-PSCUCMAxlQuery -Times 1 -Exactly -ModuleName PSCUCM
#     }
#     AfterAll {
#         Disconnect-PSCucm
#     }
# }