IPMO $PSScriptRoot\PSCUCM\PSCUCM.psd1 -Force
$secpasswd = ConvertTo-SecureString "ciscopsdt" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("administrator", $secpasswd)
connect-pscucm -AXLVersion 11.5 -server 10.10.20.1 -SkipCertificateCheck -Credential $mycreds
Get-PSCUCMPhone -DN 101