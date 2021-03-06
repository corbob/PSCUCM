Import-Module $PSScriptRoot\..\..\..\PSCUCM.psd1 -Force

Describe "Invoke-PSCUCMAxlQuery" {
    BeforeAll {
        $connectPSCucmSplat = @{
            AXLVersion           = 11.5
            Server               = '127.0.0.1'
            Credential           = [System.Management.Automation.PSCredential]::new('user', (ConvertTo-SecureString 'pass' -AsPlainText -Force))
            SkipCertificateCheck = $true
        }
        Connect-PSCucm @connectPSCucmSplat
    }
    It "Correctly set the server" {
        Get-PSFConfigValue -FullName 'pscucm.server' | Should -BeExactly $connectPSCucmSplat.server
    }
    It "Correctly set the AXLVersion" {
        Get-PSFConfigValue -FullName 'pscucm.axlversion' | Should -BeExactly $connectPSCucmSplat.AXLVersion
    }
    It "Correctly set the credential" {
        Get-PSFConfigValue -FullName 'pscucm.credential' | Should -BeExactly $connectPSCucmSplat.credential
    }
    It "Correctly set the connected status" {
        Get-PSFConfigValue -FullName 'pscucm.connected' | Should -BeTrue
    }
    It "Correctly set the certificate check" {
        Get-PSFConfigValue -FullName 'pscucm.skipcertificatecheck' | Should -BeTrue
    }
    AfterAll {
        Disconnect-PSCucm
    }
}