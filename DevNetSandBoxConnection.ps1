# This Script will Import the current module. It will connect to the Cisco Devnet Sandbox and test by fetching a phone.
IPMO $PSScriptRoot\PSCUCM\PSCUCM.psd1 -Force
$secpasswd = ConvertTo-SecureString "ciscopsdt" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("administrator", $secpasswd)
connect-pscucm -AXLVersion 11.5 -server 10.10.20.1 -SkipCertificateCheck -Credential $mycreds -PersistSettings
Get-PSCUCMPhone -DN 101