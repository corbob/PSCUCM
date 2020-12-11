Set-ExecutionPolicy Bypass -Scope Process -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 1 -PropertyType "DWord" -Force | Out-Null
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install pwsh -y
choco install openconnect-gui -y
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module PSFramework
